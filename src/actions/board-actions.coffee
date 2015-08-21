# board actions

Reflux = require 'reflux'

module.exports = Reflux.createActions
  play:
    sync: no
    children: [
      "white"
      "black"
    ]
    paramTypes: [
      "int" # column
    ]
