module.exports = (grunt) ->

  # Task: Compass
  compassTask =
    dev:
      options:
        httpPath: "/"
        cssDir: "build/public/css"
        sassDir: "app/resources/assets/sass"
        noLineComments: false
        debugInfo: false

  # Task: Bower
  bowerTask =
    install:
      options:
        targetDir: "build/public/js/libs"
        layout: 'byType'
        install: true
        verbose: false
        cleanTargetDir: false
        cleanBowerDir: false
        bowerOptions: {}

  # Task Coffee
  coffeeTask =
    compile:
      expand: true
      flatten: false
      cwd: 'app'
      src: [ '*.coffee', '**/*.coffee' ]
      dest: 'build/'
      ext: '.js'
      options:
        bare: true
        watch: true
        force: true
        sourceMap: false

  includeSourcesTask =
    options:
      basePath: 'build/public'
      baseUrl: '/'
    myTarget:
      files:
        'build/public/index.html': 'build/public/index.html'

  copyTask =
    frontend:
      files: [
        { expand: true, cwd: 'app/public', src: [ '*.*','**/*.*' ], dest: 'build/public' }
      ]

  watchTask =
    compass:
      files: [ 'app/resources/assets/sass/main.sass' ]
      tasks: [ 'compass' ]
    frontend:
      files: [ 'app/public/**/*.*','app/public/*.*' ]
      tasks: [ 'copy:frontend', 'clean:sassArtifacts', 'includeSource' ]
    coffee:
      files: [ 'app/public/**/*.coffee','app/public/*.coffee' ]
      tasks: [ 'coffee:compile' ]
      options:
        spawn: false
    express:
      files:  [
        'app/app.coffee',
        'app/controller/*.coffee',
        'app/router/**/*.coffee'
      ]
      tasks: [ 'coffee:compile','express:dev']
      options:
        spawn: false

  cleanTask =
    all:
      src: ["build/*", "release/*"]
    sassArtifacts:
      src: ["build/public/css/vendor", "build/public/css/site","build/public/**/*.coffee"]


  uglifyTask =
    js:
      files:
        'build/public/js/libs/all.js': [
          'bower_components/jquery/jquery.js'
          'bower_components/async/lib/async.js'
          'bower_components/underscore/underscore.js'
          'bower_components/dropzone/downloads/dropzone.js'
          'bower_components/screenfull/screenfull.js'
        ],
      options:
        preserveComments: true

  expressTask =
    options: {}
    dev:
      options:
        script: 'build/app.js'
        node_env: 'development'
        debug: true
    prod:
      options:
        script: 'path/to/prod/server.js'
        node_env: 'production'

  # Configure Grunt
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    compass: compassTask
    bower: bowerTask
    coffee: coffeeTask
    copy: copyTask
    watch: watchTask
    clean: cleanTask
    uglify: uglifyTask
    express: expressTask
    includeSource: includeSourcesTask

  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-bower-task')
  grunt.loadNpmTasks('grunt-express-server')
  grunt.loadNpmTasks('grunt-include-source')

  grunt.registerTask 'default', [
    'clean:all'
    'bower'
    'compass:dev'
    'coffee'
    'uglify:js'
    'copy:frontend'
    'clean:sassArtifacts'
    'includeSource'
    'express:dev'
    'watch'
  ]
