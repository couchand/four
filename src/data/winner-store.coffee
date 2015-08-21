# winner store

Reflux = require 'reflux'

boardStore = require './board-store'
boardState = no

{BOARD_SIZE, EMPTY, BLACK, WHITE} = require '../common/constants'

DIAGONALS = BOARD_SIZE.cols + BOARD_SIZE.rows

module.exports = Reflux.createStore
  init: ->
    @listenTo boardStore, @updateBoard

  updateBoard: (value) ->
    boardState = value
    @output()

  getData: ->
    boardState = boardStore.getDefaultData()
    return EMPTY unless boardState

    for col in boardState
      current = col[0]
      count = 1
      for row in [1...col.length]
        if current is col[row]
          count += 1
          return current if count is 4 and current isnt EMPTY
        else
          current = col[row]
          count = 1

    for row in [0...boardState[0].length]
      current = boardState[0][row]
      count = 1
      for i, col of boardState when i isnt '0'
        if current is col[row]
          count += 1
          return current if count is 4 and current isnt EMPTY
        else
          current = col[row]
          count = 1

    for rowPlusCol in [3..8]
      current = no
      count = 0
      for col in [0...BOARD_SIZE.cols]
        row = rowPlusCol - col
        unless row >= 0 and row < BOARD_SIZE.rows
          current = no
          count = 0
          continue
        if current is boardState[col][row]
          count += 1
          return current if count is 4 and current isnt EMPTY
        else
          current = boardState[col][row]
          count = 1

    for rowMinusCol in [-3..2]
      current = no
      count = 0
      for col in [0...BOARD_SIZE.cols]
        row = rowMinusCol + col
        unless row >= 0 and row < BOARD_SIZE.rows
          current = no
          count = 0
          continue
        if current is boardState[col][row]
          count += 1
          return current if count is 4 and current isnt EMPTY
        else
          current = boardState[col][row]
          count = 1

    EMPTY

  getDefaultData: ->
    EMPTY

  getInitialState: ->
    EMPTY

  output: ->
    @trigger @getData()
