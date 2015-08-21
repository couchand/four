# current player store

Reflux = require 'reflux'

{WHITE, BLACK} = require '../common/constants'

historyStore = require './history-store'

module.exports = Reflux.createStore

  init: ->
    @listenTo historyStore, @updateHistory

  getDefaultData: ->
    @updateHistory historyStore.getDefaultData(), yes

  getInitialState: ->
    @getDefaultData()

  updateHistory: (history, sync=no) ->
    moves = history.length

    color = if moves % 2 is 0
      WHITE
    else
      BLACK

    if sync
      color
    else
      @trigger color
