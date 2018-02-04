import path from 'path';
import webpack from 'webpack';

import baseConfig from './webpack.config.base.babel';

const config = Object.assign({}, baseConfig, {
    entry: Object.assign(baseConfig.entry, {
        hotReload: [
            'webpack-hot-middleware/client?path=/__webpack_hmr&timeout=20000&reload=true'
        ]
    }),

    output: Object.assign(baseConfig.output, {
        filename: '[name].js'
    }),

    module: {
        rules: (baseConfig.module.rules || []).concat([{
            test: /\.scss$/,
            exclude: /node_modules/,
            use: [{
                loader: 'style-loader'
            }, {
                loader: 'css-loader',
                options: {
                    minimize: false
                }
            }, {
                loader: 'postcss-loader',
                options: {
                    config: path.resolve(__dirname, './')
                }
            }, {
                loader: 'sass-loader'
            }]
        }])
    },

    plugins: (baseConfig.plugins || []).concat([
        new webpack.HotModuleReplacementPlugin()
    ]),

    devtool: 'eval'
});

export default config;