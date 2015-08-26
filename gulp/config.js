// var manifestAssets = "./app/assets";
var components     = './app/views/components';
var publicAssets   = './public/assets';
var sourceFiles    = './gulp/assets';
// var bowerFiles     = "./vendor/assets/bower_components";

module.exports = {
  publicAssets: publicAssets,
  browserSync: {
    proxy: 'localhost:3000',
    files: ['./app/views/**']
  },
  sass: {
    src: sourceFiles + '/stylesheets/**/*.{sass,scss}',
    dest: publicAssets + '/stylesheets',
    settings: {
      indentedSyntax: true, // Enable .sass syntax!
      // sourceMap: true,
      // includePaths: [bowerFiles],
      imagePath: '/assets/images' // Used by the image-url helper
    }
  },
  images: {
    src: [
      sourceFiles + '/images/**/*.{jpg,gif,png}',
      '!' + sourceFiles + '/images/demo-rwd-src/*.{jpg,gif,png}'
    ],
    dest: publicAssets + '/images',
    options: {}
  },
  svgs: {
    src: sourceFiles + '/images/*.svg',
    dest: publicAssets + '/images',
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
  },
  responsive: {
    src: sourceFiles + '/images/demo-rwd-src/*.{jpg,png}',
    dest: sourceFiles + '/images/demo-rwd-dist',
    sets: [
      {name: 'people-*.jpg', widths: [540, 360, 240, 180]},
      {name: 'case-*.jpg', widths: [1512, 1080, 900, 720,  540, 360]},
      {
        name: 'banner-*.jpg',
        widths: [360, 540, 720, 900, 1080, 1296, 1512, 1728, 1944, 2160, 2592]
      }
    ]
  }
};
