var gulp = require('gulp');

var browserSync = require('browser-sync').create();
var del = require('del');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var csso = require('gulp-csso');
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
    return del(['./pyconcz_2018/static/css/pyconcz18.*'], { force: true });
}));


// delete all previously generated images
gulp.task('clean-img', gulp.series(function(){
    return del(['./pyconcz_2018/static/img/'], { force: true });
}));


// delete all previously generated JavaScript
gulp.task('clean-js', gulp.series(function(){
    return del(['./pyconcz_2018/static/js/'], { force: true });
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
        .src('./pyconcz_2018/static_src/scss/pyconcz18/pyconcz18.scss') // scss source
        .pipe(plumber())
        .pipe(sourcemaps.init()) // initalizes a sourcemap
        .pipe(sass().on('error', sass.logError)) // compile SCSS to CSS
        .pipe(postcss([
            autoprefixer( // automatically adds vendor prefixes if needed
                // supported browsers (from Bootstrap 4 beta: see https://github.com/twbs/bootstrap/blob/v4-dev/package.json#L136-L147)
                //
                // Official browser support policy:
                // https://getbootstrap.com/docs/4.0/getting-started/browsers-devices/#supported-browsers
                //
                "last 1 major version",
                ">= 1%",
                "Chrome >= 45", // Exact version number here is kinda arbitrary
                "Firefox >= 38",
                // Note: Edge versions in Autoprefixer & Can I Use refer to the EdgeHTML rendering engine version,
                // NOT the Edge app version shown in Edge's "About" screen.
                // For example, at the time of writing, Edge 20 on an up-to-date system uses EdgeHTML 12.
                // See also https://github.com/Fyrd/caniuse/issues/1928
                "Edge >= 12",
                "Explorer >= 10",
                // Out of leniency, we prefix these 1 version further back than the official policy.
                "iOS >= 9",
                "Safari >= 9",
                // The following remain NOT officially supported, but we're lenient and include their prefixes to avoid severely breaking in them.
                "Android >= 4.4",
                "Opera >= 30"
            ),
            require('postcss-flexbugs-fixes') // fixes flex bugs if possible: see https://github.com/philipwalton/flexbugs
        ])) // add vendor prefixes, fix flexbox bugs
        .pipe(csso()) // compresses CSS
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
