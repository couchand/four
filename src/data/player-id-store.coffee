# current player id store

Reflux = require 'reflux'

getPlayerId = ->
  if gapi? and gapi
    gapi.hangout.getLocalParticipantId()
  else
    1

module.exports = Reflux.createStore

  getDefaultData: ->
    getPlayerId()

  getInitialState: ->
    @getDefaultData()
