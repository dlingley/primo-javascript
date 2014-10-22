module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Project configuration.
  grunt.initConfig
    watch:
      coffee:
        files: ['coffeescript/*.coffee']
        tasks: 'coffee'

    coffee:
      compile:
        expand: true,
        flatten: true,
        cwd: 'coffeescript',
        src: ['*.coffee'],
        dest: 'javascript',
        ext: '.js'
  
  # Default task.
  grunt.registerTask "default", "coffee"
