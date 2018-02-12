//gulp
var gulp = require('gulp');
var browserSync = require('browser-sync').create();
var argv = require('yargs').argv;
var gulpif = require('gulp-if');
var rename = require('gulp-rename');


//sass
var sourcemaps = require('gulp-sourcemaps');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var csslint = require('gulp-csslint');
var cssnano = require('gulp-cssnano');

//images
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant');

//js
var webpackStream = require('webpack-stream');
var webpack = require('webpack');
var uglify = require('gulp-uglify');

//define
var config = require('./config');
var paths = config.paths;
var build = argv.prod;
var lint = argv.lint;

//sass
gulp.task('setBuild', function () {
  build = true;
});


//sass
gulp.task('sass', function () {
  gulp.src(paths.input.scss)
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 version', 'safari 5', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'],
      cascade: false
    }))
    .pipe(gulpif(lint,csslint()))
    .pipe(gulpif(lint,csslint.reporter()))
    .pipe(gulp.dest(paths.output.css))
    .pipe(browserSync.stream());
});

//sass
gulp.task('sass-build', function () {
  gulp.src(paths.input.scss)
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 version', 'safari 5', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'],
      cascade: false
    }))
    .pipe(sourcemaps.init())
    .pipe(cssnano())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest(paths.output.cssBuild))
    .pipe(browserSync.stream());
});

//images
gulp.task('images', function() {
  return gulp.src(paths.input.images)
    .pipe(imagemin({
      progressive: true,
      use: [pngquant()]
    }))
    .pipe(gulp.dest(paths.output.images))
    .pipe(browserSync.stream());
});

//js
gulp.task('js', function() {
  return gulp.src('')
    .pipe(webpackStream(config.webpack.dev,webpack,function(){}))
    .pipe(gulp.dest(paths.output.js))
    .pipe(browserSync.stream());
});

gulp.task('js-build', function() {
  return gulp.src('')
    .pipe(webpackStream(config.webpack.build,webpack,function(){}))
    .pipe(uglify())
    .pipe(gulp.dest(paths.output.jsBuild))
    .pipe(browserSync.stream());
});


// BrowserSync
gulp.task('browser-sync', function() {
  var files = [
    paths.input.html,
    paths.input.config
  ];

  browserSync.init(files, {
    proxy: config.domain,
    notify: false
  });
});

gulp.task('default', ['browser-sync','sass','images'], function () {
  gulp.watch(paths.input.scss,['sass']);
  gulp.watch(paths.input.js,['js']);
  gulp.watch(paths.input.images,['images']);

});

gulp.task('build', ['sass-build','images'], function(){
});