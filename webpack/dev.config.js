const WebpackNotifierPlugin = require('webpack-notifier');
const webpack = require('webpack');
const config = require('./../webpack.config');

config.plugins.push(new WebpackNotifierPlugin());
config.plugins.push(new webpack.DefinePlugin({
  'process.env': {
    NODE_ENV: JSON.stringify('development'),
  },
}));
config.devtool = 'eval-source-map';

module.exports = config;
