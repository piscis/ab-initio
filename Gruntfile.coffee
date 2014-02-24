module.exports = (grunt) ->

  # Task: Compass
  compassTask =
    dev:
      options:
        httpPath: "/"
        cssDir: "public/css"
        sassDir: "assets/sass"
        noLineComments: false
        debugInfo: false

  # Task: Bower
  bowerTask =
    install:
      options:
        targetDir: "public/lib",
        layout: 'byType',
        install: true,
        verbose: false,
        cleanTargetDir: false,
        cleanBowerDir: false,
        bowerOptions: {}

  # Task Coffee
  coffeeTask =
    files: []
    options:
      bare: false
      sourceMap: false

  copyTask =
    frontend:
      files: [
        {
          expand: true
          cwd: 'public'
          src: [ '*' ]
          dest: [ 'build/public' ]
        }
      ]

  watchTask =
    js:
      files: ['app/frontend/js/**/*.js']
      tasks: ['copy:frontend']

  # Configure Grunt
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    compass: compassTask
    bower: bowerTask
    coffee: coffeeTask
    copy: copyTask
    watch: watchTask

  grunt.loadNpmTasks('grunt-contrip-compass')
  grunt.loadNpmTasks('grunt-contrip-coffee')
  grunt.loadNpmTasks('grunt-contrip-uglify')
  grunt.loadNpmTasks('grunt-contrip-clean')
  grunt.loadNpmTasks('grunt-contrip-copy')
  grunt.loadNpmTasks('grunt-contrip-concat')
  grunt.loadNpmTasks('grunt-contrip-watch')
  grunt.loadNpmTasks('grunt-bower-task')


  grunt.registerTask 'default', [
    'clean',
    'compass:dev',
    'copy:frontend'
  ]
