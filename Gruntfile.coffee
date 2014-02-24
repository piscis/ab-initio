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
        targetDir: "build/public/libs",
        layout: 'byType',
        install: true,
        verbose: false,
        cleanTargetDir: false,
        cleanBowerDir: false,
        bowerOptions: {}

  # Task Coffee
  coffeeTask =
    compile:
      files:
        'build/app.js': [ 'app/app.coffee' ]
      options:
        bare: false
        sourceMap: false

  copyTask =
    frontend:
      files: [
        { expand: true, cwd: 'app/public', src: [ '*.*' ], dest: 'build/public' }
      ]

  watchTask =
    compass:
      files: ['app/resources/assets/sass/*.scss', 'app/resources/assets/sass/*.sass', 'app/resources/assets/sass/**/*.scss', 'app/resources/assets/sass/**/*.sass']
      tasks: ['compass']
    js:
      files: ['app/public/**/*','app/public/*.*']
      tasks: ['copy:frontend']

  cleanTask =
    all:
      src: ["build/*", "release/*"]

  # Configure Grunt
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    compass: compassTask
    bower: bowerTask
    coffee: coffeeTask
    copy: copyTask
    watch: watchTask
    clean: cleanTask

  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-bower-task')

  grunt.registerTask 'default', [
    'clean',
    'bower',
    'compass:dev',
    'copy:frontend',
    'coffee',
    'watch'
  ]
