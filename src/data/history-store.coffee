# move history store

Reflux = require 'reflux'

Actions = require '../actions/history-actions'

{BLACK, WHITE} = require '../common/constants'

globalStateStore = require './global-state-store'

history = []

module.exports = Reflux.createStore

  listenables: Actions

  init: ->
    @listenTo globalStateStore, @updateGlobalState

  getDefaultData: ->
    @getData()

  getData: ->
    @updateGlobalState globalStateStore.getDefaultData(), yes

  updateGlobalState: (state, sync=no) ->
    if 'history' of state
      try
        history = JSON.parse state.history
      catch e
        console.error e

    if sync
      history
    else
      @trigger history

  getInitialState: ->
    @getDefaultData()

  onAddMove: (move) ->
    newHistory = [].concat history
    newHistory.push move
    serialized = JSON.stringify newHistory

    gapi.hangout.data.setValue 'history', serialized
