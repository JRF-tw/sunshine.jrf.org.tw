path     = require "path"
webpack  = require "webpack"
merge    = require "webpack-merge"
notifier = require "node-notifier"

pkg      = require "./package"
parts    = require "./webpack.parts"
{ pathTo, assetHash } = parts

FriendlyErrorsWebpackPlugin = require "friendly-errors-webpack-plugin"

common_config = (env) -> merge [
  target: "web"
  context: pathTo("root")
  resolve:
    modules: [
      pathTo("root")
      pathTo("stylesheets")
      "node_modules"
    ]
    extensions: [".coffee", ".js", ".yml", ".json"]
    alias:
      icons:      pathTo("icons")
      images:     pathTo("images")
      modernizr$: path.resolve __dirname, "./.modernizrrc"
      masonry$:   "masonry-layout/dist/masonry.pkgd.js"
      isotope$:   "isotope-layout"
      gumshoe$:   "gumshoe/dist/js/gumshoe.js"
      "~susy":    "susy/sass/susy"
      "~scut":    "scut/dist/scut"
      "smooth-scroll":  "smooth-scroll/dist/js/smooth-scroll.js"
      "../img/loading.gif": "webui-popover/img/loading.gif"

  entry:
    main: [
      'animate-css-webpack!./config/animate-css.js'
      './index.coffee'
    ]
    priority: './priority.coffee'

  output:
    chunkFilename: "javascripts/webpack_chunk_[id].js"

  externals:
    "jquery": "jQuery"
    "$":      "jQuery"

  parts.loadCoffeeScript()
  parts.loadJavaScript()
  parts.loadSvgSprite()
  parts.loadImage env
  parts.loadModernizr()
]

module.exports = (env) ->
  if env.target is "development"
    return merge [
      common_config env
      plugins: [
        new webpack.NamedModulesPlugin()
        new webpack.LoaderOptionsPlugin { debug: on }
        new FriendlyErrorsWebpackPlugin
          onErrors: (severity, errors) ->
            if severity isnt "error" then return
            error = errors[0]
            notifier.notify
              title: error.name
              subtitle: error.origin
              message: error.webpackError.details
              sound: "Sosumi"
      ]
      parts.devServer()
      parts.loadStylesheet()
    ]

  return merge [
    common_config env
    output:
      path: path.resolve __dirname, env.build_path
      publicPath: pkg.publicPath
      filename: "javascripts/webpack_[name].js"
    plugins: [
      new webpack.DefinePlugin
        "process.env":
          "NODE_ENV": JSON.stringify "production"
      new webpack.NoEmitOnErrorsPlugin()
    ]
    parts.extractStylesheet env
  ]
