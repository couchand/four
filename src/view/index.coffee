# connect four

React = require 'react'

{table} = React.DOM

Header = require './header'
Board = require './board'
Status = require './status'

module.exports = React.createFactory React.createClass

  name: 'connect-four'
  displayName: 'Connect Four'

  render: ->
    table
      className: 'connect-four'

      Header()
      Board()
      Status()
