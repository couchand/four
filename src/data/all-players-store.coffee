# all players store

Reflux = require 'reflux'

participants = gapi.hangout.getEnabledParticipants()

gapi.hangout.onEnabledParticipantsChanged.add ({enabledParticipants}) ->
  participants = enabledParticipants
  store.output()

module.exports = store = Reflux.createStore

  getDefaultData: ->
    participants

  getInitialState: ->
    @getDefaultData()

  output: ->
    @trigger @getDefaultData()
