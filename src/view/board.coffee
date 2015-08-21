# board view

React = require 'react'
Reflux = require 'reflux'

{
  tbody, tr, td
} = React.DOM

Piece = require './piece'

{EMPTY, WHITE, BLACK, BOARD_SIZE} = require '../common/constants'

boardStore = require '../data/board-store'

module.exports = React.createFactory React.createClass

  name: 'connect-four.board'
  displayName: 'Board'

  mixins: [Reflux.connect boardStore, 'board']

  render: ->
    tbody
      className: 'board'

      for row in [BOARD_SIZE.rows-1..0]
        tr
          key: "row-#{row}"

          for col in [0...BOARD_SIZE.cols]
            td
              key: "col-#{col}"

              Piece color: @state.board[col][row]
