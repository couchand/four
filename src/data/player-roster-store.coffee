# player roster store

Reflux = require 'reflux'

globalStateStore = require '../data/global-state-store'

Actions = require '../actions/player-roster-actions'

{BLACK, WHITE} = require '../common/constants'

getNewGame = ->
  game = {}
  game[BLACK] = no
  game[WHITE] = no
  game

games =
  current: getNewGame()
  next: getNewGame()

module.exports = Reflux.createStore

  listenables: Actions

  init: ->
    @listenTo globalStateStore, @updateGlobalState

  getDefaultData: ->
    @getData()

  getData: ->
    @updateGlobalState globalStateStore.getDefaultData(), yes

  updateGlobalState: (state, sync=no) ->
    if 'current.white' of state
      games.current[WHITE] = state['current.white']
    if 'current.black' of state
      games.current[BLACK] = state['current.black']
    if 'next.white' of state
      games.next[WHITE] = state['next.white']
    if 'next.black' of state
      games.next[BLACK] = state['next.black']

    if sync
      games
    else
      @trigger games

  getInitialState: ->
    @getDefaultData()

  onUpdateCurrentGame: (color, player) ->
    if games.current[color]
      throw new Error 'cannot change player'

    key = "current.#{if color is BLACK then 'black' else 'white'}"
    gapi.hangout.data.setValue key, player

  onUpdateNextGame: (color, player) ->
    if games.next[color]
      throw new Error 'cannot change player'

    key = "next.#{if color is BLACK then 'black' else 'white'}"
    gapi.hangout.data.setValue key, player

  onAdvanceGame: ->
    games.current = games.next
    games.next = getNewGame()

    @trigger games
