class State
  @DOT_PATTERN: /\./

  constructor: ->
    @_state = {}
    @callbacks = {}
    this.throttledTriggerChange = _.debounce(this.triggerChange, 100)

  set: (key, value) ->
    this._setState(@_state, key, value)
    this.throttledTriggerChange()

  triggerChange: =>
    this.trigger('change')

  update: (key, value) ->

  get: (key) ->
    this._getState(@_state, key)

  on: (event, callback) ->
    @callbacks[event] ||= []
    @callbacks[event].push(callback)

  trigger: (event) ->
    @callbacks[event] ||= []
    @callbacks[event].forEach (callback) =>
      callback(this)

  _getState: (state, key) ->
    if this._hasDot(key)
      [head, tail] = this._decomposeKey(key)
      newState = state[head]
      this._getState(newState, tail)
    else
      state[key]

  _setState: (state, key, value) ->
    if this._hasDot(key)
      [head, tail] = this._decomposeKey(key)
      state[head] ||= {}
      newState = state[head]
      this._setState(newState, tail, value)
    else
      state[key] = value

  _hasDot: (string) ->
    State.DOT_PATTERN.test(string)

  _decomposeKey: (key) ->
    parts = key.split('.')
    head = parts.shift()
    tail = parts.join('.')
    [head, tail]

module.exports = new State()

