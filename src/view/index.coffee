# four

React = require 'react'

{div, table} = React.DOM

Header = require './header'
Board = require './board'
Status = require './status'
Roster = require './roster'

module.exports = React.createFactory React.createClass

  name: 'four'
  displayName: 'Four'

  render: ->
    div
      className: 'four'

      table {},
        Header()
        Board()
        Status()

      Roster()
