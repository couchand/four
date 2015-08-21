# player roster actions

Reflux = require 'reflux'

module.exports = Reflux.createActions
  updateCurrentGame:
    sync: no

  updateNextGame:
    sync: no

  advanceGame:
    sync: yes
