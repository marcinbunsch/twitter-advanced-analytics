Database = require('database')

class Exporter
  constructor: ->
    this.exportUrl = '/user/marcinbunsch/tweets/export.json?start_time=1409529600000&end_time=1411948800000&lang=en'
    this.bundleUrl = '/user/marcinbunsch/tweets/bundle?start_time=1409529600000&end_time=1411948800000&lang=en'

  requestExport: (callback) ->
    console.log('Requested export')
    $.get(this.exportUrl).success (data) =>
      if data.status == 'Available'
        console.log('Export available')
        callback(data)
      else
        console.log('Waiting for data')
        retry = => this.requestExport(callback)
        setTimeout(retry, 1000)

  loadExport: (callback) ->
    this.requestExport (data) =>
      console.log('Loading data')
      $.get(this.bundleUrl).success(callback)

module.exports = Exporter
