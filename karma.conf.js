var webpack = require('webpack');
var commonConfig = require('./webpack/karma-common.conf.js');

module.exports = function (config) {
  config.set(commonConfig);
};
