gulp      = require 'gulp'
open      = require 'open'
jade      = require 'gulp-jade'
gutil     = require 'gulp-util'
karma     = require 'gulp-karma'
ngmin     = require 'gulp-ngmin'
coffee    = require 'gulp-coffee'
stylus    = require 'gulp-stylus'
concat    = require 'gulp-concat'
uglify    = require 'gulp-uglify'
usemin    = require 'gulp-usemin'
notify    = require 'gulp-notify'
inject    = require 'gulp-inject'
connect   = require 'gulp-connect'
imagemin  = require 'gulp-imagemin'
protactor = require 'gulp-protractor'


paths =
  views:    'src/**/*.jade'
  styles:   'src/styles/**/*.styl'
  images:   'src/images/**/*'
  scripts:  'src/scripts/**/*.coffee'

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee bare: yes
    .pipe ngmin()
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'dist/scripts'


gulp.task 'scripts-dev', ->
  gulp.src paths.scripts
    .pipe coffee
      bare: yes
      sourceMap: yes
    .pipe gulp.dest 'app/scripts'
    .pipe connect.reload()


gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'dist/styles'

gulp.task 'styles-dev', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'app/styles'
    .pipe connect.reload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe imagemin()
    .pipe gulp.dest 'dist/images'

gulp.task 'images-dev', ->
  gulp.src paths.images
    .pipe gulp.dest 'app/images'
    .pipe connect.reload()

gulp.task 'views', ->
  gulp.src paths.views
    .pipe jade()
    .pipe gulp.dest 'dist/'

gulp.task 'views-dev', ->
  gulp.src paths.views
    .pipe jade pretty: yes
    .pipe gulp.dest 'app/'
    .pipe connect.reload()

gulp.task 'serve', ->
  connect.server
    port       : 1337
    root       : [paths.dest]
    livereload : yes

  open 'http://localhost:1337', 'safari'

gulp.task 'watch', ->
  gulp.watch paths.views   , ['views-dev']
  gulp.watch paths.styles  , ['styles-dev']
  gulp.watch paths.scripts , ['scripts-dev']
  gulp.watch paths.images  , ['images-dev']

gulp.task 'build'   , ['scripts'     , 'styles'     , 'images'     , 'views']
gulp.task 'compile' , ['scripts-dev' , 'styles-dev' , 'images-dev' , 'views-dev']
gulp.task 'default' , ['compile'     , 'watch'      , 'serve']