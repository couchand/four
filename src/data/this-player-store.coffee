# this player store

Reflux = require 'reflux'

{WHITE} = require '../common/constants'

thisPlayer = WHITE

module.exports = Reflux.createStore

  getDefaultData: ->
    thisPlayer

  getInitialState: ->
    @getDefaultData()
