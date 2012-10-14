chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/intervalsymbol"

describe "IntervalSymbol", ->

  leftIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("[")
  rightIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("]")

  describe "#constructor()", ->

    it "throws exception when symbol is not recognized", ->
      expect(-> new FUNDDY.JsTranslations.IntervalSymbol("")).to.throw(Error)

  describe "#isLeftOpen()", ->

    it "returns false when symbol is type left", ->
      leftIntervalSymbol.isLeftOpen().should.equal(false)

    it "returns true when symbol is type right", ->
      rightIntervalSymbol.isLeftOpen().should.equal(true)

  describe "#isLeftClose()", ->

    it "returns true when symbol is type left", ->
      leftIntervalSymbol.isLeftClose().should.equal(true)

    it "returns false when symbol is type right", ->
      rightIntervalSymbol.isLeftClose().should.equal(false)

  describe "#isRightOpen()", ->

    it "returns true when symbol is type left", ->
      leftIntervalSymbol.isRightOpen().should.equal(true)

    it "returns false when symbol is type right", ->
      rightIntervalSymbol.isRightOpen().should.equal(false)

  describe "#isRightClose()", ->

    it "returns false when symbol is type left", ->
      leftIntervalSymbol.isRightClose().should.equal(false)

    it "returns true when symbol is type right", ->
      rightIntervalSymbol.isRightClose().should.equal(true)