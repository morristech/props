var webpack = require('webpack');
var commonConfig = require('./webpack/karma-common.conf.js');

module.exports = function (config) {
  commonConfig.eslint.stopOnError = true;
  commonConfig.eslint.stopOnWarning = true;
  config.set(commonConfig);
};
