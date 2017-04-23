path     = require 'path'
path_to  = require './'
webpack  = require 'webpack'
merge    = require 'webpack-merge'
ip       = require 'ip'

pkg = require path_to.package

ExtractTextPlugin = require "extract-text-webpack-plugin"

base_svg_plugins = [
  {cleanupIDs: on}
  {removeTitle: on}
  {removeComments: on}
  {removeDesc: on}
  {removeDimensions: on}
  {removeUselessStrokeAndFill: on}
]

config =
  svg_sprite: JSON.stringify
    spriteModule: path.resolve path_to.root, "config/custom-sprite"
    name: 'icon-[name]'
  svg_icon: JSON.stringify
    plugins: [
      base_svg_plugins...
      {convertColors: {currentColor: on}}
    ]
  svg_image: JSON.stringify
    plugins: base_svg_plugins

module.exports = (env) ->
  webpack_config =
    context: path_to.root
    resolve:
      root: [
        path_to.root
        path_to.sass
      ]
      extensions: ['', '.coffee', '.js']
      alias:
        icons:      path_to.icons
        images:     path_to.images
        modernizr$: path.join path_to.root, ".modernizrrc"
        masonry:    "masonry-layout/dist/masonry.pkgd.js"
        isotope:    "isotope-layout"
        gumshoe:    "gumshoe/dist/js/gumshoe.js"
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
      path: path_to.assets
      filename: 'javascripts/webpack_[name].js'
      chunkFilename: 'javascripts/webpack_chunk_[id].js'

    module:
      loaders: [
        test: /\.coffee$/
        loader: 'coffee-loader'
        include: path_to.root
      ,
        test: /\.js$/
        loader: 'babel?cacheDirectory'
        include: path_to.root
      ,
        test: /\.svg$/
        include: path_to.icons
        loaders: [
          "svg-sprite?#{config.svg_sprite}"
          "svgo?#{config.svg_icon}"
        ]
      ,
        test: /\.svg$/i
        include: path_to.images
        loaders: [
          "file?name=images/[name].[ext]"
          "svgo?#{config.svg_image}"
        ]
      ,
        test: /\.(png|jpe?g|gif)$/i
        include: [
          path_to.images
          path.resolve(path_to.root, '../node_modules/webui-popover/img')
          path.resolve(path_to.root, '../node_modules/chosen-js')
        ]
        loaders: [
          "file?name=images/[name].[ext]"
          "img?progressive=true"
        ]
      ,
        test: /\.modernizrrc$/
        loaders: ["modernizr", "yaml"]
      # ,
      #   test: /\.js$/
      #   include: "node_modules"
      #   loader: "imports?this=>window, define=>false"
      # AMD fix
      ]
    externals:
      "jquery": "jQuery"
      "$":      "jQuery"

    sassLoader:
      includePaths: [path_to.sass]
    postcss: [
      require("autoprefixer")(
        browsers: [
          'last 2 versions'
          'last 3 Safari versions'
          'Safari 8'
          'Android 4.3'
        ]
      )
      require("postcss-assets")(
        loadPaths: [
          path_to.images
          path_to.icons
        ]
      )
      require("postcss-short")()
      require("postcss-clearfix")()
      require("postcss-strip-units")()
      require("postcss-calc")()
    ]

    # Factor out common dependencies into a shared.js
    # plugins:
    #   new webpack.optimize.CommonsChunkPlugin
    #     name: 'shared'
    #     filename: 'javascripts/[name].js'

  if env is 'development'
    webpack_config = merge webpack_config,
      output:
        publicPath: "http://#{ip.address()}:8080" + pkg.publicPath
      devtool: 'eval'
      devServer:
        progress: on
        stats: 'errors-only'
        host: '0.0.0.0'
        port:  8080
      debug: on
      module:
        loaders: [
          test: /\.(sass|scss)$/
          include: path_to.sass
          loaders: [
            "style"
            "css?sourceMap"
            "postcss"
            "resolve-url"
            "sass?sourceMap"
          ]
        ,
          test: /\.css$/
          loader: "style!css"
        ]

  if env is 'production'
    optimize_plugins = [
      new webpack.DefinePlugin
        'process.env':
          'NODE_ENV': JSON.stringify 'production'
      new webpack.optimize.DedupePlugin()
      # new webpack.optimize.UglifyJsPlugin(compress: {warnings: false})
      new webpack.NoErrorsPlugin()
    ]

    webpack_config = merge webpack_config,
      output:
        publicPath: pkg.publicPath

      module:
        loaders: [
          test: /\.(sass|scss)$/
          include: path_to.sass
          loader: ExtractTextPlugin.extract "style",
            "css!postcss!resolve-url!sass?sourceMap"
        ,
          test: /\.css$/
          loader: ExtractTextPlugin.extract "style", "css"
        ]

      plugins: [
        optimize_plugins...
        new ExtractTextPlugin('stylesheets/webpack_bundle.scss', { allChunks: true })
      ]

  return webpack_config
