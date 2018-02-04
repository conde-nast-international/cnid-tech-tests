import path from 'path';
import webpack from 'webpack';
import ImageMinPlugin from 'imagemin-webpack-plugin';
import ExtractTextPlugin from 'extract-text-webpack-plugin';

import baseConfig from './webpack.config.base.babel';

const config = Object.assign({}, baseConfig, {
    output: Object.assign(baseConfig.output, {
        filename: '[name].[hash].js'
    }),

    module: {
        rules: (baseConfig.module.rules || []).concat([{
            test: /\.scss$/,
            exclude: /node_modules/,
            loader: ExtractTextPlugin.extract({
                fallback: 'style-loader',
                use: [{
                    loader: 'css-loader',
                    options: {
                        minimize: true
                    }
                }, {
                    loader: 'postcss-loader',
                    options: {
                        config: path.resolve(__dirname, './')
                    }
                }, {
                    loader: 'sass-loader'
                }]
            })
        }])
    },

    plugins: (baseConfig.plugins || []).concat([
        new ImageMinPlugin({
            pngquant: {
                quality: '95-100'
            }
        }),
        new webpack.optimize.UglifyJsPlugin({
            comments: false,
            compress: {
                warnings: false
            }
        }),
        new ExtractTextPlugin({
            filename: '[name].[hash].css'
        })
    ]),

    devtool: 'cheap-source-map'
});

export default config;