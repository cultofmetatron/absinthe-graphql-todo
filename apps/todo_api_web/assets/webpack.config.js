let path = require('path');

module.exports = {
  entry: {
    app: path.join(__dirname, "js/app.js")
  },
  output: {
    path: path.join(__dirname, "../priv/static/js"),
    filename: "[name].js"
  },
  resolve: {
    modules: [ "node_modules" ]
  },
  module: {
    loaders: [
      {
        test: /.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        query: {
          presets: ['es2015', 'es2016', 'es2017', 'react']
        }
      }, 
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        query: {
          presets: ["es2015", "es2016", "es2017"]
        }
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader'
      }
    ]
  }
};