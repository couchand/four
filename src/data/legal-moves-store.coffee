# legal moves store

Reflux = require 'reflux'

{EMPTY, BOARD_SIZE} = require '../common/constants'

boardStore = require './board-store'

boardState = no

module.exports = Reflux.createStore
  init: ->
    @listenTo boardStore, @updateBoard
    boardState = boardStore.getDefaultData()

  updateBoard: (value) ->
    boardState = value
    @output()

  getData: ->
    moves = []
    return moves unless boardState

    for col in [0...BOARD_SIZE.cols]
      emptySpot = boardState[col].indexOf EMPTY
      moves.push col if emptySpot isnt -1

    moves

  getDefaultData: ->
    @getData()

  getInitialState: ->
    @getData()

  output: ->
    @trigger @getData()
