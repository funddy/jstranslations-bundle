chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/translator"

require "#{__dirname}/../src/interval"
require "#{__dirname}/../src/intervalparser"
require "#{__dirname}/../src/set"
require "#{__dirname}/../src/setfactory"

describe "Translator", ->

  IRRELEVANT_TRANSLATION = "XXXX"

  translationsData = {"es": {
    "id1": IRRELEVANT_TRANSLATION,
    "id2": "%parameter%",
    "id3": "{0} There is no apples|{1} There is one apple|]1,Inf[ There are %count% apples"
  }}

  dummyInterval = null
  intervalParserStub = null
  translator = null

  beforeEach ->
    dummyInterval = new FUNDDY.JsTranslations.Interval()
    intervalParserStub = new root.FUNDDY.JsTranslations.IntervalParser()
    translator = new FUNDDY.JsTranslations.Translator(intervalParserStub, translationsData, "es")

  describe "#trans()", ->

    it "throws exception if locale doesn't exist", ->
      expect(-> new FUNDDY.JsTranslations.Translator(translationsData, "fr")).to.throw(Error)

    it "throws exception if translation id doesn't exist", ->
      expect(-> translator.trans("")).to.throw(Error)

    it "generates valid text", ->
      expect(translator.trans("id1")).to.eql(IRRELEVANT_TRANSLATION)

    it "replace parameters correctly", ->
      expect(translator.trans("id2", {"%parameter%": "test"})).to.eql("test")

  describe "#transChoice()", ->

    it "throws exception if number doesn't match multiple choice", ->
      intervalParseShouldReturnIntervalsThatNeverContainsNumber()
      expect(-> translator.transChoice("id3", 1)).to.throw(Error)

    intervalParseShouldReturnIntervalsThatNeverContainsNumber = ->
      sinon.stub(dummyInterval, "contains").returns(false)
      sinon.stub(intervalParserStub, "parse").returns(dummyInterval)

    it "throws exception if number doesn't match multiple choice", ->
      intervalParseShouldReturnAnIntervalThatContainsTheNumber()
      translator.transChoice("id3", 0).should.equal("There is no apples")

    intervalParseShouldReturnAnIntervalThatContainsTheNumber = ->
      sinon.stub(dummyInterval, "contains").returns(true)
      sinon.stub(intervalParserStub, "parse").returns(dummyInterval)