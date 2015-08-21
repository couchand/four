# status section

React = require 'react'
Reflux = require 'reflux'

{
  tfoot, tr, td, a
} = React.DOM

{BOARD_SIZE, WHITE, BLACK, EMPTY} = require '../common/constants'

currentPlayerStore = require '../data/current-player-store'
allPlayersStore = require '../data/all-players-store'
playerRosterStore = require '../data/player-roster-store'
winnerStore = require '../data/winner-store'

{advanceGame} = require '../actions/player-roster-actions'

module.exports = React.createFactory React.createClass

  name: 'four.status'
  displayName: 'Status'

  mixins: [
    Reflux.connect currentPlayerStore, 'currentPlayer'
    Reflux.connect playerRosterStore, 'players'
    Reflux.connect allPlayersStore, 'allPlayers'
    Reflux.connect winnerStore, 'winner'
  ]

  handleAdvanceGame: (e) ->
    e.preventDefault()
    advanceGame()

  render: ->
    byId = {}
    for player in @state.allPlayers
      byId[player.id] = player.person.displayName

    whiteName = byId[@state.players.current[WHITE]]
    blackName = byId[@state.players.current[BLACK]]

    tfoot
      className: 'status'
      tr {},
        td
          colSpan: BOARD_SIZE.cols

          if !whiteName?
            "Waiting on the first player."

          else if !blackName?
            "Waiting on the second player."

          else if @state.winner isnt EMPTY
            switch @state.winner
              when WHITE then "#{whiteName} wins!"
              when BLACK then "#{blackName} wins!"

          else
            switch @state.currentPlayer
              when WHITE then "#{whiteName}'s turn."
              when BLACK then "#{blackName}'s turn."

      tr {},
        td
          colSpan: BOARD_SIZE.cols
          if @state.winner isnt EMPTY
            a
              href: '#'
              onClick: @handleAdvanceGame
              'Advance to next game...'
