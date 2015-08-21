# four game

React = require 'react'

Game = require './view'

module.exports = four = (el) ->

    React.render Game(), el

window.four = four if window
