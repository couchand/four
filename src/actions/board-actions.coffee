# board actions

Reflux = require 'reflux'

module.exports = Reflux.createActions
  play:
    sync: yes
    children: [
      "white"
      "black"
    ]
    paramTypes: [
      "int" # column
    ]
