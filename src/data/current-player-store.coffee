# current player store

Reflux = require 'reflux'

Actions = require '../actions/current-player-actions'
{WHITE, BLACK} = require '../common/constants'

currentPlayer = WHITE

module.exports = Reflux.createStore

  listenables: Actions

  getDefaultData: ->
    currentPlayer

  getInitialState: ->
    @getDefaultData()

  output: ->
    @trigger currentPlayer

  onSwitchPlayer: ->
    currentPlayer = switch currentPlayer
      when WHITE then BLACK
      else WHITE

    @trigger currentPlayer
