var path = require('path');
var webpack = require('webpack');

var root = __dirname;
var PATHS = {
  root: root,
  src: path.resolve(root, 'public/src/js'),
  app: path.resolve(root, 'public/src/js/main.js'),
  nodeModule: path.resolve(root, 'node_modules'),
  appDev: path.resolve(root, 'public/src/js'),
  appBuild: path.resolve(root, 'public/dist/js')
};

var config = {
  dev: {
    debug: true,
    cache: true,
    watch: false,
    entry: {
      app: [PATHS.app],
      vendor: ['device.js']
    },
    output: {
      path: PATHS.appDev,
      filename: '[name].js',
      chunkFilename: '[name]-[chunkhash].js'
    },
    externals: {
      "jquery": "jQuery"
    },
    module : {  
      preLoaders: [
        {
          test: /\.jsx?$/,
          loader: 'standard',
          exclude: /(node_modules|bower_components)/
        }
      ]
    },
    standard: {
      parser: 'babel-eslint'
    },
    plugins: [
      new webpack.optimize.CommonsChunkPlugin('vendor', 'vendor.js'),
    ]
  }
};

config.build = config.dev;
config.build.devtool = 'inline-source-map' ;
config.build.output.path = PATHS.appBuild; 

module.exports = config;