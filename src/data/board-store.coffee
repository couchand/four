# board state store

Reflux = require 'reflux'

Actions = require '../actions/board-actions'

{EMPTY, BLACK, WHITE, BOARD_SIZE} = require '../common/constants'
{switchPlayer} = require '../actions/current-player-actions'

getEmptyBoard = ->
  for col in [0...BOARD_SIZE.cols]
    for row in [0...BOARD_SIZE.rows]
      EMPTY

boardState = getEmptyBoard()

module.exports = Reflux.createStore

  listenables: Actions

  getDefaultData: ->
    boardState

  getInitialState: ->
    @getDefaultData()

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

    boardState[column][landed] = color

    switchPlayer()

    @trigger boardState
