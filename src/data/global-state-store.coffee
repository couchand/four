# global hangouts state

Reflux = require 'reflux'

module.exports = Reflux.createStore

  getDefaultData: ->
    gapi.hangout.data.getState()

  getInitialState: ->
    @getDefaultData()

  init: ->
    gapi.hangout.onApiReady.add =>
      gapi.hangout.data.onStateChanged.add ({state}) =>
        @trigger state
