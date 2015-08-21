var changed    = require('gulp-changed');
var gulp       = require('gulp');
var svgmin     = require('gulp-svgmin');
var config     = require('../config').svgs;
var browserSync  = require('browser-sync');

gulp.task('svgs', function() {
  return gulp.src(config.src)
    .pipe(changed(config.dest)) // Ignore unchanged files
    .pipe(svgmin(config.options)) // Optimize
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));
});
