# roster view

React = require 'react'
Reflux = require 'reflux'

{
  table, tbody, tfoot, tr, th, td, a, img
} = React.DOM

Piece = require './piece'

{WHITE, BLACK} = require '../common/constants'

playerIdStore = require '../data/player-id-store'
allPlayersStore = require '../data/all-players-store'
playerRosterStore = require '../data/player-roster-store'
{updateCurrentGame, updateNextGame} = require '../actions/player-roster-actions'

module.exports = React.createFactory React.createClass

  name: 'four.roster'
  displayName: 'Roster'

  mixins: [
    Reflux.connect playerIdStore, 'playerId'
    Reflux.connect allPlayersStore, 'allPlayers'
    Reflux.connect playerRosterStore, 'players'
  ]

  handleCurrent: (color) -> (e) =>
    updateCurrentGame color, @state.playerId
    e.preventDefault()

  handleNext: (color) -> (e) =>
    updateNextGame color, @state.playerId
    e.preventDefault()

  render: ->
    cg = @state.players.current
    ng = @state.players.next

    byId = {}
    for player in @state.allPlayers
      byId[player.id] = player.person.displayName

    table
      className: 'roster'
      tbody {},
        tr {},
          th
            colSpan: 2
            "Current Game"

        tr {},
          td {},
            Piece color: WHITE
          td {},
            if cg[WHITE]
              byId[cg[WHITE]]
            else unless cg[BLACK] is @state.playerId
              a
                href: '#'
                onClick: @handleCurrent WHITE
                "Play"
        tr {},
          td {},
            Piece color: BLACK
          td {},
            if cg[BLACK]
              byId[cg[BLACK]]
            else unless cg[WHITE] is @state.playerId
              a
                href: '#'
                onClick: @handleCurrent BLACK
                "Play"

        tr {},
          th
            colSpan: 2
            "Next Game"

        tr {},
          td {},
            Piece color: WHITE
          td {},
            if ng[WHITE]
              byId[ng[WHITE]]
            else unless ng[BLACK] is @state.playerId
              a
                href: '#'
                onClick: @handleNext WHITE
                "Play"
        tr {},
          td {},
            Piece color: BLACK
          td {},
            if ng[BLACK]
              byId[ng[BLACK]]
            else unless ng[WHITE] is @state.playerId
              a
                href: '#'
                onClick: @handleNext BLACK
                "Play"

      tfoot {},
        tr {},
          th
            colSpan: 2
            "All Players"

        tr {},
          for player in @state.allPlayers
            [
              td
                key: 'image'
                img
                  className: 'avatar'
                  src: player.person.image.url
              td
                key: 'name'
                player.person.displayName
            ]
