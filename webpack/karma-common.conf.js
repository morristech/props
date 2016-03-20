module.exports = {
  browsers: ['Chrome'],
  singleRun: true,
  frameworks: ['mocha', 'sinon'],
  files: ['webpack/tests.config.js', {pattern: './app/react/**/*', watched: false, included: false, served: false}],
  preprocessors: {
    'webpack/tests.config.js': ['webpack', 'sourcemap'],
    'app/react/**/*.js*': ['eslint'],
  },
  reporters: ['dots'],
  webpack: {
    module: {
      loaders: [
        {
          test: /\.jsx?$/,
          exclude: /node_modules/,
          loader: 'babel'
        }]
    },
    watch: true,
    resolve: {
      extensions: ["", ".js", ".jsx", ".js.jsx"]
    },
    devtool: 'inline-source-map',
  },
  webpackServer: {
    noInfo: true
  },
  eslint: {
    engine: {
      configFile: '.eslintrc',
    },
    stopOnError: false,
    stopOnWarning: false,
    showWarnings: false
  }
}
