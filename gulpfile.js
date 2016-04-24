var gulp = require('gulp');
var sass = require('gulp-sass');
var gulpif = require('gulp-if');
var useref = require('gulp-useref');
var minifyCss = require('gulp-minify-css');

gulp.task('styles', function() {
    gulp.src('assets/scss/styles.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./public/'))
});

gulp.task('html', function () {
    return gulp.src('views/layout.erb')
        .pipe(useref())
        .pipe(gulpif('*.js', uglify()))
        .pipe(gulpif('*.css', minifyCss()))
        .pipe(gulp.dest('./public/'));
});

//Watch task
gulp.task('default',function() {
	// gulp.watch('views/layout.erb', ['html'])
    gulp.watch('assets/scss/*.scss',['styles']);
});