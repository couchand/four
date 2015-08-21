# connect four game

React = require 'react'

Game = require './view'

module.exports = connectFour = (el) ->

    React.render Game(), el

window.connectFour = connectFour if window
