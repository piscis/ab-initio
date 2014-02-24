module.exports = () ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),
    compass: compass
    coffee: coffee
    uglify: uglify
    clean: clean
    copy: copy

  grunt.loadNpmTasks('grunt-contrip-compass')
  grunt.loadNpmTasks('grunt-contrip-coffee')
  grunt.loadNpmTasks('grunt-contrip-uglify')
  grunt.loadNpmTasks('grunt-contrip-clean')
  grunt.loadNpmTasks('grunt-contrip-copy')
  grunt.loadNpmTasks('grunt-contrip-concat')
  grunt.loadNpmTasks('grunt-contrip-watch')
