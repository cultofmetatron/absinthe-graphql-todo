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
    modules: [ path.resolve(__dirname, 'js'), path.resolve(__dirname, 'node_modules') ],
    extensions: ['.tsx', '.ts','.js', 'jsx', 'css', 'scss']
  },
  devtool: "source-map",
  plugins: [
  ],
  module: {
    loaders: [
      {
        test: /(\.css|\.scss)$/,
        //loader: 'style-loader!css-loader?sourceMap&modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!postcss-loader',
         loaders: ['style-loader', 'css-loader?sourceMap&modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]', 'postcss-loader'],
      },
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
        test: /\.tsx?$/,
        exclude: /node_modules/,
        loader: "awesome-typescript-loader" 
      },
      { enforce: "pre", test: /\.js$/, loader: "source-map-loader" }
     ]
  },
  externals: {
    //"react": "React",
    //"react-dom": "ReactDOM"
  },
};