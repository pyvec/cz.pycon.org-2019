var gulp = require('gulp');

var autoprefixer = require('autoprefixer');
var flexbugs = require('postcss-flexbugs-fixes');
var browserSync = require('browser-sync').create();
var clean = require('gulp-clean');
var postcss = require('gulp-postcss');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var cleanCSS = require('gulp-clean-css');
var watch = require('gulp-watch');
var exec = require('child_process').exec;
var plumber = require('gulp-plumber');


/*
 * TASKS
 */

// runs django dev server
gulp.task('runserver', gulp.series(function(done){
  exec('python manage.py runserver --settings=pyconcz_2018.settings.local', function(err, stdout, stderr){
    console.log(stdout);
    console.log(stderr);
  });
  done();
}));


// delete all previously generated CSS
gulp.task('clean-css', gulp.series(function(){
  return gulp.src('./pyconcz_2018/static/css/', { read: false, allowEmpty: true }).pipe(clean());
}));


// delete all previously generated images
gulp.task('clean-img', gulp.series(function(){
  return gulp.src('./pyconcz_2018/static/img/', { read: false, allowEmpty: true }).pipe(clean());
}));



// delete all previously generated JavaScript
gulp.task('clean-js', gulp.series(function(){
  return gulp.src('./pyconcz_2018/static/js/', { read: false, allowEmpty: true }).pipe(clean());
}));



// copy images
gulp.task('copy-img', gulp.series('clean-img', function(){
  return gulp
    .src(['./pyconcz_2018/static_src/img/**/*'])
    .pipe(gulp.dest('./pyconcz_2018/static/img/'))
    .pipe(browserSync.stream());
}));


// compile CSS
gulp.task('compile-css', gulp.series('clean-css', function(){
  return gulp
    .src('./pyconcz_2018/static_src/scss/pyconcz.scss') // scss source
    .pipe(plumber())
    .pipe(sass())
    .pipe(sourcemaps.init()) // sourcemap for developer tools
    .pipe(postcss([
      autoprefixer({
        'browsers': [
          '> 0.2%',
          'last 3 versions'
        ]
      }),
      flexbugs()
    ])) // add vendor prefixes, fix flexbox bugs
    .pipe(cleanCSS({
      compatibility: 'ie11',
      roundingPrecision: 4,
      advanced: true,
      rebase: false,
      specialComments: 0,
      processImport: false,
      inline: ['none']
    }))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./pyconcz_2018/static/css/')) // resulting CSS
    .pipe(browserSync.stream()); // tell BrowserSync to inject CSS
}));


gulp.task('build', gulp.parallel('compile-css', 'copy-img')); // build everything before deployment


// Build files and proxy dev server on http://localhost:3000
// Watch for changes in files and do what is neccessary
gulp.task(
  'develop',
  gulp.series('build', 'runserver', function(){
    browserSync.init({
      proxy: {
        target: 'http://127.0.0.1:8000' // Django is running here
      },
      open: false,
      files: [
        './pyconcz_2018/templates/**/*.html'
      ]
    });
    gulp.watch('./pyconcz_2018/static_src/scss/**/*.scss', gulp.series('compile-css')); // watcher for SCSS
    gulp.watch('./pyconcz_2018/static_src/img/**/*', gulp.series('copy-img')); // watcher for images
  })
);



gulp.task('default', gulp.series('develop')); // just run gulp to start development
