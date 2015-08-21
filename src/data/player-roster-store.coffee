# player roster store

Reflux = require 'reflux'

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

  getDefaultData: ->
    games

  getInitialState: ->
    @getDefaultData()

  onUpdateCurrentGame: (color, player) ->
    if games.current[color]
      throw new Error 'cannot change player'

    games.current[color] = player

    console.log games, color, player

    @trigger games

  onUpdateNextGame: (color, player) ->
    if games.next[color]
      throw new Error 'cannot change player'

    games.next[color] = player

    console.log games, color, player

    @trigger games

  onAdvanceGame: ->
    games.current = games.next
    games.next = getNewGame()

    @trigger games
