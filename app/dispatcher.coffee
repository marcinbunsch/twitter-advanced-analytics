DatabaseUpdater = require('database_updater')
Database = require('database')
State = require('state')
Blacklist = require('blacklist')
WeekAnalyzer = require('week_analyzer')

Dispatcher =
  start: ->

  updateDatabase: ->
    new DatabaseUpdater().update () ->
      Dispatcher.loadDatabaseToState()

  loadDatabaseToState: ->
    Database.allDocs { descending: true, include_docs: true}, (err, response) ->
      State.set 'boot', false
      State.set 'tweets', response.rows

  showBehaviorPage: ->
    tweets = State.get('tweets') || []
    result = new WeekAnalyzer(tweets).analyze()
    State.set 'context', 'behavior'
    State.set 'week_analysis_context', 'impressions'
    State.set 'week_analysis', result

  showDatabasePage: ->
    State.set 'context', 'database'

  toggleIgnore: (tweet) ->
    Blacklist.toggle(tweet.id)
    State.set 'blacklist', Blacklist

  setWeekAnalysisContext: (key) ->
    State.set 'week_analysis_context', key

module.exports = Dispatcher


