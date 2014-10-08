Exporter = require('exporter')
Database = require('database')

class DatabaseUpdater

  update: (callback) ->
    exporter = new Exporter()
    exporter.loadExport (exportData) ->
      console.log('Data loaded')
      parsed = Papa.parse(exportData, { header: true })
      parsed.data.forEach (row) ->
        row._id = row['Tweet id']
        row._rev = new Date().getTime().toString() + '-version'
      Database.bulkDocs parsed.data, { "new_edits": false }, (err, response) ->
        console.log('Database updated')
        callback() if callback

module.exports = DatabaseUpdater

