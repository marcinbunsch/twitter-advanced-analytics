class Blacklist

  constructor: ->
    @ignored = {}

  toggle: (id) ->
    id = id.toString()
    if @ignored[id]
      delete @ignored[id]
    else
      @ignored[id] = true
    this.writeToStorage()

  isIgnored: (id) ->
    id = id.toString()
    @ignored[id]

  loadFromStorage: ->
    json = localStorage.getItem(this.localStorageKey)
    if json
      @ignored = JSON.parse(json)
    console.log(@ignored)

  writeToStorage: ->
    json = JSON.stringify(@ignored)
    localStorage.setItem(this.localStorageKey, json)

  localStorageKey: 'twitter.advanced.blacklist'

blacklist = new Blacklist()
blacklist.loadFromStorage()

module.exports = blacklist

