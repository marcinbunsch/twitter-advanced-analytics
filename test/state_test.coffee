assert = require("assert")
State = require("../app/state")

describe "State", ->

  state = null

  beforeEach ->
    state = new State()

  describe "initialization", ->

    it "starts with empty state", ->
      assert.deepEqual(state._state, {})

  describe "#set", ->

    context "with a simple key and value", ->

      it "sets the value", ->
        state.set('simple', 'value')
        stored = state.get('simple')
        assert.equal(stored, 'value')

    context "with a complex key", ->

      it "sets the value", ->
        state.set('complex.key', 'value')
        stored = state.get('complex.key')
        assert.equal(stored, 'value')

      it "is accessible on the higher level", ->
        state.set('complex.key', 'value')
        stored = state.get('complex')
        assert.deepEqual(stored, { key: 'value' })

  describe "#update", ->

  describe "#get", ->

    context "invalid key", ->

      it "throws an error", ->
        error = null
        try
          state.get('not.existent.key')
        catch e
          error = e
        assert.equal(error.name, 'TypeError')
        assert.equal(error.type, 'non_object_property_load')

