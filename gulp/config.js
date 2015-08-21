var manifestAssets = "./app/assets";
var components     = "./app/views/components";
var publicAssets   = "./public/assets";
var sourceFiles    = "./gulp/assets";
var bowerFiles     = "./vendor/assets/bower_components";

module.exports = {
  publicAssets: publicAssets,
  browserSync: {
    proxy: 'localhost:3000',
    files: ['./app/views/**']
  },
  sass: {
    src: sourceFiles + "/stylesheets/**/*.{sass,scss}",
    dest: publicAssets + "/stylesheets",
    settings: {
      indentedSyntax: true, // Enable .sass syntax!
      // sourceMap: true,
      // includePaths: [bowerFiles],
      imagePath: '/assets/images' // Used by the image-url helper
    }
  },
  images: {
    src: sourceFiles + "/images/**/*.{jpg,gif,png}",
    dest: publicAssets + "/images",
    options: {}
  },
  svgs: {
    src: sourceFiles + "/images/*.svg",
    dest: publicAssets + "/images",
    options: [
      {cleanupIDs: true},
      {removeComments: true},
      {removeDesc: true }
    ]
  },
  browserify: {
    bundleConfigs: [{
      entries: sourceFiles + '/javascripts/global.coffee',
      dest: publicAssets + '/javascripts',
      outputName: 'global.js',
      extensions: ['.js','.coffee']
    }]
  },
  wiredep: {
    sassSrc: sourceFiles + '/stylesheets/_requirements.sass',
    sassDest: sourceFiles + '/stylesheets',
    options: {
      // json: require('./bower.json'),
      // directory: bowerFiles,
      ignorePath: /^(\.\.\/)+/
    }
  },
  svgSprite: {
    src: sourceFiles + '/icons/**',
    view: components + '/_svgs.slim',
    dest: components,
    prefix: 'icon-',
    options: {
      inlineSvg: true
    },
    minOptions: [
      {cleanupIDs: true},
      {removeComments: true},
      {removeDesc: true}
    ]
  }
};
