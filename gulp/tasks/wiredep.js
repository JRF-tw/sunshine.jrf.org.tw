var gulp    = require('gulp');
var wiredep = require('wiredep').stream;
var handleErrors = require('../util/handleErrors');
var config  = require('../config').wiredep;

gulp.task('wiredep', function () {
  gulp.src(config.sassSrc)
    .pipe(wiredep(config.options))
    .on('error', handleErrors)
    .pipe(gulp.dest(config.sassDest));
});