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
    playerRoster = playerRosterStore.getDefaultData()
    playerId = playerIdStore.getDefaultData()

    @getData()

  getData: ->
    for color, id of playerRoster.current when id is playerId
        return +color

    EMPTY

  getInitialState: ->
    @getDefaultData()

  output: ->
    @trigger @getData()
