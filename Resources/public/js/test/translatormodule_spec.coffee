chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

# Global vars
global.FUNDDY.JsTranslations.Translations = {"en": {
  "test.id.simple": "This is a %word% test"
  "test.id.choice": "{0} There is no apples|{1} There is one apple|]1,Inf[ There are a lot of apples"
  "test.id.choice.parameters": "{0} No elements|{1} One element|]1,Inf] %count% elements"
  "test.id.outofchoice": "{0} No choices",
  "test.id.invalidrange": "{test",
  "test.id.empty": ""
}}
global.FUNDDY_JSTRANSLATIONS_LOCALE = "en"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/interval"
require "#{__dirname}/../src/intervalfactory"
require "#{__dirname}/../src/intervalparser"
require "#{__dirname}/../src/intervalsymbol"
require "#{__dirname}/../src/intervalsymbolfactory"
require "#{__dirname}/../src/set"
require "#{__dirname}/../src/setfactory"
require "#{__dirname}/../src/translatormodule"
require "#{__dirname}/../src/translator"

describe "TranslatorModule", ->

  describe "#trans()", ->

    it "replaces parameters with values", ->
      Translator.trans("test.id.simple", {"%word%": "simple"}).should.equal("This is a simple test")

    it "throws exception if id was not found", ->
      expect(-> Translator.transChoice("non.existent.id", 0)).to.throw(Error)

  describe "#transChoice()", ->

    it "throws exception if id was not found", ->
      expect(-> Translator.transChoice("non.existent.id", 0)).to.throw(Error)

    it "parse and process interval set", ->
      Translator.transChoice("test.id.choice", 0).should.equal("There is no apples")
      Translator.transChoice("test.id.choice", 1).should.equal("There is one apple")

    it "parse and process interval", ->
      Translator.transChoice("test.id.choice", 2).should.equal("There are a lot of apples")

    it "replaces parameters with values", ->
      Translator.transChoice("test.id.choice.parameters", 2, {"%count%": 2}).should.equal("2 elements")

    it "throws exception if choice number was not found", ->
      expect(-> Translator.transChoice("test.id.outofchoice", 1)).to.throw(Error)

    it "throws exception if choice is malformed", ->
      expect(-> Translator.transChoice("test.id.invalidrange", 2)).to.throw(Error)

    it "throws exception if choice is empty", ->
      expect(-> Translator.transChoice("test.id.empty", 0)).to.throw(Error)