import React from 'react';
import path from 'path';
import express from 'express';
import compression from 'compression';
import staticAsset from 'static-asset';
import zLib from 'zlib';
import handlebars  from 'express-handlebars';
import nodeJsx from 'node-jsx';
import { match, RouterContext } from 'react-router';
import { renderToString } from 'react-dom/server';

import api from '../api';
import routes from '../routes';

const ONE_YEAR_IN_MILLIS = 31557600000;
const APP_PORT_NUM = process.env.PORT || 3000;

const app = express();

if (process.env.NODE_ENV === 'development') {
    const webpack = require('webpack');
    const webpackDevMiddleware = require('webpack-dev-middleware');
    const webpackHotMiddleware = require('webpack-hot-middleware');

    const webpackConfig = require('../config/webpack.config.dev.babel.js').default;
    const compiler = webpack(webpackConfig);

    app.use(webpackDevMiddleware(compiler, {
        publicPath: webpackConfig.output.publicPath,
        noInfo: true
    }));

    app.use(webpackHotMiddleware(compiler, {
        log: console.log
    }));
}

/**
 * Transpile Jsx from node.
 * */
nodeJsx.install();

/**
 * Gzip compression
 * */
app.use(compression({
    threshold: 0,
    level: zLib.Z_BEST_COMPRESSION
}));

/**
 * Indicating our static folder and setting caching duration
 * */
app.use('/dist', staticAsset(path.resolve(__dirname, '../../dist/'), { maxAge: ONE_YEAR_IN_MILLIS }));
app.use('/dist', express.static(path.resolve(__dirname, '../../dist/'), { maxAge: ONE_YEAR_IN_MILLIS }));

/**
 * View engine Handlebars
 * */
app.set('view engine', 'hbs');
app.engine('hbs', handlebars({
    extname:'.hbs',
    partialsDir: path.resolve(__dirname, '../views/layout/partials')
}));
app.set('views', path.resolve(__dirname, '../views/layout/'));

/**
 * Bind the APIs
 * */
api(app);

/**
 * Handle status codes and direct all other paths to react-router.
 * */
app.get('*', (req, res) => {
    match({ routes: routes, location: req.url }, (error, redirect, props) => {
        if (error) {
            res.status(500).send(error.message);
        } else if (redirect) {
            res.redirect(302, redirect.pathname + redirect.search);
        } else if (props) {
            res.status(200);
            res.render('index', { reactOutput: renderToString(<RouterContext {...props} />) });
        }
    });
});

app.listen(APP_PORT_NUM, () => console.log(`Server running at http://localhost:${APP_PORT_NUM}`));