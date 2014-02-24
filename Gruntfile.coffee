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
    'compass:dev',
    'copy:frontend'
  ]
