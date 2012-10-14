chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/set"

describe "Set", ->

  set = new FUNDDY.JsTranslations.Set([3, 2, 1, 4])

  describe "#contains()", ->

    it "returns true if it contains the number", ->
      set.contains(4).should.equal(true)

    it "returns false if it doesn't contain the number", ->
      set.contains(11).should.equal(false)