# this player store

Reflux = require 'reflux'

{EMPTY} = require '../common/constants'

playerRosterStore = require './player-roster-store'
playerIdStore = require './player-id-store'

playerRoster = no
playerId = no

module.exports = Reflux.createStore

  init: ->
    @listenTo playerRosterStore, @updatePlayers
    @listenTo playerIdStore, @updateId

  updatePlayers: (value) ->
    playerRoster = value
    @output()

  updateId: (value) ->
    playerId = value
    @output()

  getDefaultData: ->
    EMPTY

  getInitialState: ->
    @getDefaultData()

  output: ->
    for color, id of playerRoster.current
      console.log color, id
      if id is playerId
        @trigger +color
        return

    @trigger EMPTY
