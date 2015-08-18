var browserSync = require('browser-sync');
var config      = require('../config').svgSprite;
var gulp        = require('gulp');
var inject      = require('gulp-inject');
var cheerio      = require('gulp-cheerio');
var svgmin    = require('gulp-svgmin');
var svgstore    = require('gulp-svgstore');

gulp.task('svg-sprite', function() {
  var svgs = gulp
      .src(config.src)
      .pipe(svgmin(config.minOptions))
      .pipe(cheerio({
          run: function ($) {
              $('[fill]').removeAttr('fill');
              $('svg').attr('style',  'display:none');
          },
          parserOptions: { xmlMode: true }
      }))
      .pipe(svgstore(config.options));

  function fileContents (filePath, file) {
    return file.contents.toString();
  }

  return gulp
    .src(config.view)
    .pipe(inject(svgs, {transform: fileContents}))
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({
      stream: true
    }));
});
