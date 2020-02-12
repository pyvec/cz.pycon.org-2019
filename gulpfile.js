const gulp = require('gulp');

const browserSync = require('browser-sync').create();
const del = require('del');
const sass = require('gulp-sass');
const sourcemaps = require('gulp-sourcemaps');
const postcss = require('gulp-postcss');
const csso = require('gulp-csso');
const { spawn } = require('child_process');
const plumber = require('gulp-plumber');
const rename = require('gulp-rename');


/*
 * TASKS
 */

// runs django dev server
gulp.task('runserver', gulp.series(
    function runDjangoDevServer(done){
        const djangoDevServer = spawn(
            'env/bin/python',
            ['manage.py', 'runserver', '--settings=pyconcz.settings.local']
        );

        djangoDevServer.stdout.on('data', data => {
            console.log('[django server] ' + data);

            if (data.toString().match(/.*Quit the server with CONTROL-C.*/g)){
                console.log('\n-------------------- django server restarted --------------------\n');
                browserSync.notify('Python has changed, if stuck reloading, reload manually.', 10000);
                setTimeout(browserSync.reload, 2000);
            }
        });

        djangoDevServer.stderr.on('data', data => {
            console.log('[django server] ' + data);
        });

        djangoDevServer.on('close', code => {
            console.log('[django server] exited with code ' + code);
            done(code);
        });
    }
));


// copy images
gulp.task('copy:img', gulp.series(
    function imgCleanup(){ // delete all previously copied images
        return del(['./pyconcz/static/img/'], { force: true });
    },
    function imgCopy(){
        return gulp
            .src(['./pyconcz/static_src/img/**/*'])
            .pipe(gulp.dest('./pyconcz/static/img/'))
            .pipe(browserSync.stream());
    }
));


// compile CSS
gulp.task('compile:css', gulp.series(
    function cssCleanup(){ // delete all previously generated CSS
        return del(['./pyconcz/static/css/pyconcz19.*'], { force: true });
    },
    function compileCss(){
        return gulp
            .src('./pyconcz/static_src/scss/pyconcz19/pyconcz19.scss') // scss source
            .pipe(plumber())
            .pipe(sourcemaps.init()) // initalizes a sourcemap
            .pipe(sass().on('error', sass.logError)) // compile SCSS to CSS
            .pipe(postcss([
                require('autoprefixer'), // automatically adds vendor prefixes if needed
                // see browserslist in package.json for included browsers
                // Official Bootstrap browser support policy:
                // https://getbootstrap.com/docs/4.4/getting-started/browsers-devices/#supported-browsers
                require('postcss-flexbugs-fixes') // fixes flex bugs if possible: see https://github.com/philipwalton/flexbugs
            ]))
            .pipe(csso()) // compresses CSS
            .pipe(rename('pyconcz19.min.css'))
            .pipe(gulp.dest('./pyconcz/static/css/')) // resulting CSS without sourcemap
            .pipe(rename('pyconcz19.css'))
            .pipe(sourcemaps.write('.'))
            .pipe(gulp.dest('./pyconcz/static/css/')) // resulting CSS with sourcemap
            .pipe(browserSync.stream()); // tell BrowserSync to inject CSS
    }
));


// proxy dev server on http://localhost:3838
gulp.task('browsersync', gulp.series(
    function startBrowsersync(){
        browserSync.init({
                proxy: {
                    target: 'http://127.0.0.1:8000' // Django is running here
                },
                port: 3838,
                host: 'pycon.test',
                open: false,
                files: [
                    './pyconcz/templates/**/*.html',
                ]
            },
            function watchOtherFiles(){
                gulp.watch('./pyconcz/static_src/scss/**/*.scss', gulp.series('compile:css')); // watcher for SCSS
                gulp.watch('./pyconcz/static_src/img/**/*', gulp.series('copy:img')); // watcher for images
            }
        );
    }
));

// build everything
gulp.task('build', gulp.parallel('compile:css', 'copy:img'));

// development
gulp.task('develop', gulp.series('build', gulp.parallel('runserver', 'browsersync')));

// just a default task defined (you can run just `npx gulp` to start it)
gulp.task('default', gulp.series('develop'));
