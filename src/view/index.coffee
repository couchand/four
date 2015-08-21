# four

React = require 'react'

{table} = React.DOM

Header = require './header'
Board = require './board'
Status = require './status'

module.exports = React.createFactory React.createClass

  name: 'four'
  displayName: 'Four'

  render: ->
    table
      className: 'four'

      Header()
      Board()
      Status()
