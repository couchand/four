# board state store

Reflux = require 'reflux'

Actions = require '../actions/board-actions'

historyStore = require './history-store'

{EMPTY, BLACK, WHITE, BOARD_SIZE} = require '../common/constants'
{addMove} = require '../actions/history-actions'

getEmptyBoard = ->
  for col in [0...BOARD_SIZE.cols]
    for row in [0...BOARD_SIZE.rows]
      EMPTY

boardState = getEmptyBoard()

getBoardForHistory = (history) ->
  board = getEmptyBoard()

  color = WHITE

  for column in history
    unless column >= 0 and column < BOARD_SIZE.cols
      throw new Error "illegal column index"

    landed = board[column].indexOf EMPTY

    if landed is -1
      throw new Error "column already full"

    board[column][landed] = color
    color = if color is WHITE then BLACK else WHITE

  board

module.exports = Reflux.createStore

  listenables: Actions

  init: ->
    @listenTo historyStore, @updateHistory

  getDefaultData: ->
    @getData()

  getInitialState: ->
    @getDefaultData()

  getData: ->
    @updateHistory historyStore.getDefaultData(), yes

  updateHistory: (history, sync=no) ->
    board = getBoardForHistory history

    if sync
      board
    else
      @trigger board

  onPlayWhite: (column) ->
    @play WHITE, column

  onPlayBlack: (column) ->
    @play BLACK, column

  play: (color, column) ->
    unless column >= 0 and column < BOARD_SIZE.cols
      throw new Error "illegal column index"

    landed = boardState[column].indexOf EMPTY

    if landed is -1
      throw new Error "column already full"

    addMove column
