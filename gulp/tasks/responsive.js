var gulp        = require('gulp');
var responsive  = require('gulp-responsive');
var browserSync = require('browser-sync');
var config      = require('../config').responsive;

gulp.task('responsive', function () {
  return gulp.src(config.src)
    .pipe(responsive(buildSet(config.sets)))
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));    
});

function widthSet (widths) {
  var   i = widths.length,
      set = [];
  while (i--) {
    set.push({
      width: widths[i],
      rename: {suffix: '-' + widths[i]}
    });
  }
  return set;
}

function buildSet (sets) {
  var result = {},
           i = sets.length;
  while (i--) {
    result[sets[i].name] = widthSet(sets[i].widths);
  }
  return result;
}