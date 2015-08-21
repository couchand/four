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
    games.current[WHITE] = if 'current.white' of state
      state['current.white']
    else
      no

    games.current[BLACK] = if 'current.black' of state
      state['current.black']
    else
      no

    games.next[WHITE] = if 'next.white' of state
      state['next.white']
    else
      no

    games.next[BLACK] = if 'next.black' of state
      state['next.black']
    else
      no

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
    newState =
      history: '[]'

    removals = ['next.white', 'next.black']

    if games.next[WHITE]
      newState['current.white'] = games.next[WHITE]
    else
      removals.push 'current.white'

    if games.next[BLACK]
      newState['current.black'] = games.next[BLACK]
    else
      removals.push 'current.black'

    gapi.hangout.data.submitDelta newState, removals
