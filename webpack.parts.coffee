fs      = require "fs"
path    = require "path"
webpack = require "webpack"
ip      = require "ip"
pkg     = require "./package"

ExtractTextPlugin = require "extract-text-webpack-plugin"

svgo_plugins = [
  {cleanupIDs: on}
  {removeTitle: on}
  {removeComments: on}
  {removeDesc: on}
  {removeDimensions: on}
  {removeUselessStrokeAndFill: on}
]

###*
 * Stylesheet loaders before style-loader
 * @param  {[Object]} options [config of css-loader]
 * @return {[Array]}          [loaders]
###
cssPreLoaders = (options) ->
  [
    "css-loader?#{JSON.stringify options}"
    "postcss-loader"
    "resolve-url-loader?#{JSON.stringify
      root: "./client/"}"
    "sass-loader?#{JSON.stringify
      includePaths: [pathTo("stylesheets")]
      sourceMap: on}"
    "sass-resources-loader?#{JSON.stringify
      resources: path.join pathTo('stylesheets'), '_resource.scss'}"
  ]

assetHash = ({asset_hash}) -> if asset_hash then '-[hash]' else ''

pathTo = (dest) -> path.resolve __dirname, pkg.paths[dest]

exports.assetHash = assetHash
exports.pathTo = pathTo

exports.devServer = (options) ->
  output:
    publicPath: "http://#{ip.address()}:8080" + pkg.publicPath
    filename: "javascripts/webpack_[name].js"
  devtool: "eval"
  devServer:
    historyApiFallback: on
    hot: on
    stats: "errors-only"
    port:  8080
    host:  "0.0.0.0"
    disableHostCheck: on
  plugins: [
    new webpack.HotModuleReplacementPlugin mutiStep: on
  ]

exports.loadStylesheet = (options) ->
  module:
    rules: [
      test: /\.(sass|scss)$/
      include: pathTo("stylesheets")
      use: [
        "style-loader"
        cssPreLoaders({sourceMap: on})...
      ]
    ,
      test: /\.css$/
      use: ["style-loader", "css-loader"]
    ]

exports.extractStylesheet = (env) ->
  module:
    rules: [
      test: /\.(sass|scss)$/
      include: pathTo("stylesheets")
      use: ExtractTextPlugin.extract
        fallback: "style-loader"
        use: cssPreLoaders()
    ,
      test: /\.css$/
      use: ExtractTextPlugin.extract
        fallback: "style-loader"
        use: "css-loader"
    ]
  plugins: [
    new ExtractTextPlugin
      filename: "stylesheets/webpack_bundle.scss"
      allChunks: on
  ]

exports.loadCoffeeScript = (options) ->
  module:
    rules: [
      test: /\.coffee$/
      use: [
        "babel-loader?cacheDirectory"
        "coffee-loader"
      ]
      include: pathTo("root")
    ]

exports.loadJavaScript = (options) ->
  module:
    rules: [
      test: /\.js$/
      loader: "babel-loader?cacheDirectory"
      exclude: /node_modules/
    ]

exports.loadSvgSprite = (options) ->
  module:
    rules: [
      test: /\.svg$/
      include: pathTo("icons")
      use: [
        loader: "svg-sprite-loader"
        options:
          spriteModule: path.join pathTo("config"), "custom-sprite"
          name: "icon-[name]"
      ,
        loader: "image-webpack-loader"
        options:
          bypassOnDebug: off
          svgo:
            plugins: [
              svgo_plugins...
              convertColors: {currentColor: on}
            ]
      ]
    ]

exports.loadImage = (env) ->
  module:
    rules: [
      test: /\.(png|jpe?g|gif|svg)$/i
      exclude: pathTo("icons")
      use: [
        "file-loader?name=images/[name].[ext]"
        loader: "image-webpack-loader"
        options:
          bypassOnDebug: on
          mozjpeg:
            quality: 70
          pngquant:
            quality: "65-90"
            speed: 7
          svgo:
            plugins: svgo_plugins
      ]
    ]

exports.loadModernizr = (options) ->
  module:
    rules: [
      test: /\.modernizrrc$/
      use: ["modernizr-loader", "json-loader", "yaml-loader"]
    ]

###*
 * Load module which isn't CommonJS format.
 * @param  {[Regex]} pattern [module path]
 * @return {[Object]}        [module rules]
###
exports.loadAMDModule = (pattern) ->
  module:
    rules: [
      test: /\.js$/
      include: pattern
      loader: "imports?this=>window, define=>false"
    ]

exports.uglifyJs = ->
  plugins: [new webpack.optimize.UglifyJsPlugin()]
