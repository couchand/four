# build all the things

module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      build:
        expand: yes
        flatten: no
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'build'
        ext: '.js'

    browserify:
      build:
        src: ['build/**/*.js']
        dest: 'dist/<%= pkg.name %>.js'

    uglify:
      options:
        banner: """
                /*! <%= pkg.name %> v<%= pkg.version %>
                 *  <%= grunt.template.today("yyyy-mm-dd") %>
                 */

                """
      build:
        src: ['<%= browserify.build.dest %>']
        dest: 'dist/<%= pkg.name %>.min.js'

    copy:
      build:
        src: '<%= browserify.build.dest %>'
        dest: 'www/<%= pkg.name %>.js'

    concat:
      hangouts:
        src: [
          'hangouts/header.xml'
          'hangouts/index.html'
          'hangouts/footer.xml'
        ]
        dest: 'dist/<%= pkg.name %>.xml'

    clean:
      coffee: '<%= coffee.build.dest %>'
      browserify: '<%= browserify.build.dest %>'
      copy: '<%= copy.build.dest %>'
      dist: 'dist/'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['clean', 'coffee', 'browserify', 'uglify', 'copy', 'concat']
