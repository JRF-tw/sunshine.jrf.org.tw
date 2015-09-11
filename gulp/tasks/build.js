var gulp         = require('gulp');
var gulpSequence = require('gulp-sequence')

gulp.task('build', function(cb) {
  var tasks = [['images', 'svgs', 'svg-sprite'], ['sass', 'browserify']];
  tasks.push(cb);
  gulpSequence.apply(this, tasks);
});
