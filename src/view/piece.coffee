# one piece

React = require 'react'

{
  svg, circle
} = React.DOM

{EMPTY, WHITE, BLACK} = require '../common/constants'

module.exports = React.createFactory React.createClass

  name: 'four.piece'
  displayName: 'Piece'

  propTypes:
    color: React.PropTypes.oneOf([WHITE, BLACK, EMPTY]).isRequired

  render: ->
    svg
      width: 32
      height: 32

      circle
        cx: 16
        cy: 16
        r: 15
        stroke: 'black'
        fill: switch @props.color
          when WHITE then 'red'
          when BLACK then 'black'
          else 'white'
