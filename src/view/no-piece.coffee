# no piece

React = require 'react'

{
  svg
} = React.DOM

module.exports = React.createFactory React.createClass

  name: 'four.no-piece'
  displayName: 'No Piece'

  render: ->
    svg
      width: 32
      height: 32
