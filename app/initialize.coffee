AppComponent = require('components/app')
State = require('state')
Hijacker = require('hijacker')
Dispatcher = require('dispatcher')
Blacklist = require('blacklist')

Hijacker.addAdvancedLink()

if window.location.search.match('advanced')
  Hijacker.takeOverPage()
  State.set 'boot', true
  State.set 'context', 'database'
  State.set 'blacklist', Blacklist

  renderAppComponent = ->
    console.log('rendering')
    React.renderComponent(AppComponent({ data: State }), Hijacker.mount())

  State.on 'change', renderAppComponent
  renderAppComponent()
  Dispatcher.loadDatabaseToState()
  Dispatcher.updateDatabase()

