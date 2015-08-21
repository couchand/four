# header to play

React = require 'react'
Reflux = require 'reflux'

{
  thead, tr, td
} = React.DOM

Piece = require './piece'
NoPiece = require './no-piece'

{BOARD_SIZE, WHITE, EMPTY} = require '../common/constants'

currentPlayerStore = require '../data/current-player-store'
thisPlayerStore = require '../data/this-player-store'
legalMovesStore = require '../data/legal-moves-store'
winnerStore = require '../data/winner-store'

{play} = require '../actions/board-actions'

module.exports = React.createFactory React.createClass

  name: 'four.header'
  displayName: 'Header'

  mixins: [
    Reflux.connect currentPlayerStore, 'currentPlayer'
    Reflux.connect thisPlayerStore, 'thisPlayer'
    Reflux.connect legalMovesStore, 'legalMoves'
    Reflux.connect winnerStore, 'winner'
  ]

  handleMouseOver: (col) -> =>
    @setState hovering: col

  handleMouseOut: (col) -> =>
    @setState hovering: null

  handleClick: (col) -> =>
    return unless @state.currentPlayer is @state.thisPlayer
    switch @state.currentPlayer
      when WHITE then play.white col
      else play.black col

  render: ->
    console.log 'header', @state

    if @state.currentPlayer is @state.thisPlayer
      thead {},
        tr {},
          for col in [0...BOARD_SIZE.cols]
            if col in @state.legalMoves and @state.winner is EMPTY
              td
                key: "col-#{col}"
                onClick: @handleClick col
                onMouseOver: @handleMouseOver col
                onMouseOut: @handleMouseOut col
                if @state.hovering is col
                  Piece color: @state.currentPlayer
                else
                  NoPiece()
            else
              td
                key: "col-#{col}"
                NoPiece()
    else
      thead {},
        tr {},
          for col in [0...BOARD_SIZE.cols]
            td
              key: "col-#{col}"
              NoPiece()
