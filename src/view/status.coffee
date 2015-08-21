# status section

React = require 'react'
Reflux = require 'reflux'

{
  tfoot, tr, td
} = React.DOM

{BOARD_SIZE, WHITE, BLACK, EMPTY} = require '../common/constants'

currentPlayerStore = require '../data/current-player-store'
winnerStore = require '../data/winner-store'

module.exports = React.createFactory React.createClass

  name: 'connect-four.status'
  displayName: 'Status'

  mixins: [
    Reflux.connect currentPlayerStore, 'currentPlayer'
    Reflux.connect winnerStore, 'winner'
  ]

  render: ->
    tfoot
      className: 'status'
      tr {},
        td
          colSpan: BOARD_SIZE.cols

          if @state.winner isnt EMPTY
            switch @state.winner
              when WHITE then "White wins!"
              when BLACK then "Black wins!"

          else
            switch @state.currentPlayer
              when WHITE then "White's turn."
              when BLACK then "Black's turn."
