chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/setfactory"
require "#{__dirname}/../src/intervalfactory"
require "#{__dirname}/../src/intervalsymbolfactory"
require "#{__dirname}/../src/intervalparser"

describe "IntervalParser", ->

  IRRELEVANT_SET = "XXX"
  IRRELEVANT_INTERVAL = "XXXX"
  IRRELEVANT_INTERVAL_SYMBOL = "XXXXX"

  setFactoryStub = null
  intervalFactoryStub = null
  intervalSymbolFactoryStub = null
  intervalParser = null

  beforeEach ->
    setFactoryStub = createSetFactoryStub()
    intervalFactoryStub = createIntervalFactoryStub()
    intervalSymbolFactoryStub = createIntervalSymbolFactoryStub()
    intervalParser = new FUNDDY.JsTranslations.IntervalParser(setFactoryStub, intervalFactoryStub, intervalSymbolFactoryStub)

  createSetFactoryStub = ->
    setFactoryStub = new FUNDDY.JsTranslations.SetFactory()
    sinon.stub(setFactoryStub, "create").returns(IRRELEVANT_SET)
    setFactoryStub

  createIntervalFactoryStub = ->
    intervalFactoryStub = new FUNDDY.JsTranslations.IntervalFactory()
    sinon.stub(intervalFactoryStub, "create").returns(IRRELEVANT_INTERVAL)
    intervalFactoryStub

  createIntervalSymbolFactoryStub = ->
    intervalSymbolFactoryStub = new FUNDDY.JsTranslations.IntervalSymbolFactory()
    sinon.stub(intervalSymbolFactoryStub, "create").returns(IRRELEVANT_INTERVAL_SYMBOL)
    intervalSymbolFactoryStub

  describe "#parse()", ->

    it "returns a Set object for a given set string", ->
      testSets = ["{0}", "{0,-3}", "{0,-3,4}"]
      intervalParser.parse(set).should.equal(IRRELEVANT_SET) for set in testSets

    it "returns a Interval object for a given interval string", ->
      testIntervals = ["]1,2]", "]1,2[", "[1,2]", "[1,2[", "]-1,2]", "]-Inf,Inf]"]
      intervalParser.parse(interval).should.equal(IRRELEVANT_INTERVAL) for interval in testIntervals

    it "throws parse error for malformed input", ->
      malformedStrings = ["]1,", "{}", "}"]
      expect(-> intervalParser.parse(malformedString)) for malformedString in malformedStrings
