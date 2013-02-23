# Global vars
window.TRANSLATIONS =
  "en":
    "test.id.simple": "This is a %word% test"
    "test.id.choice": "{0} There is no apples|{1} There is one apple|]1,Inf[ There are a lot of apples"
    "test.id.choice.parameters": "{0} No elements|{1} One element|]1,Inf] %count% elements"
    "test.id.outofchoice": "{0} No choices",
    "test.id.invalidrange": "{test",
    "test.id.empty": ""

describe "TranslatorModule", ->

  translator = null

  before ->
    translator = window.Translator

  describe "#trans()", ->

    it "replaces parameters with values", ->
      expect(translator.trans("test.id.simple", {"%word%": "simple"})).to.be("This is a simple test")

    it "throws exception if id was not found", ->
      expect(-> translator.transChoice("non.existent.id", 0)).to.throwError()

  describe "#transChoice()", ->

    it "throws exception if id was not found", ->
      expect(-> translator.transChoice("non.existent.id", 0)).to.throwError()

    it "parse and process interval set", ->
      expect(translator.transChoice("test.id.choice", 0)).to.be("There is no apples")
      expect(translator.transChoice("test.id.choice", 1)).to.be("There is one apple")

    it "parse and process interval", ->
      expect(translator.transChoice("test.id.choice", 2)).to.be("There are a lot of apples")

    it "replaces parameters with values", ->
      expect(translator.transChoice("test.id.choice.parameters", 2, {"%count%": 2})).to.be("2 elements")

    it "throws exception if choice number was not found", ->
      expect(-> translator.transChoice("test.id.outofchoice", 1)).to.throwError()

    it "throws exception if choice is malformed", ->
      expect(-> translator.transChoice("test.id.invalidrange", 2)).to.throwError()

    it "throws exception if choice is empty", ->
      expect(-> translator.transChoice("test.id.empty", 0)).to.throwError()