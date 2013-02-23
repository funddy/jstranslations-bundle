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
    dummyInterval = new FUNDDY.JsTranslations.Interval("{", "3", "3", "}")
    intervalParserStub = new FUNDDY.JsTranslations.IntervalParser()
    translator = new FUNDDY.JsTranslations.Translator(intervalParserStub, translationsData, "es")

  describe "#trans()", ->

    it "throws exception if locale doesn't exist", ->
      expect(-> new FUNDDY.JsTranslations.Translator(translationsData, "fr")).to.throwError()

    it "throws exception if translation id doesn't exist", ->
      expect(-> translator.trans("")).to.throwError()

    it "generates valid text", ->
      expect(translator.trans("id1")).to.be(IRRELEVANT_TRANSLATION)

    it "replace parameters correctly", ->
      expect(translator.trans("id2", {"%parameter%": "test"})).to.be("test")

  describe "#transChoice()", ->

    it "throws exception if number doesn't match multiple choice", ->
      intervalParseShouldReturnIntervalsThatNeverContainsNumber()
      expect(-> translator.transChoice("id3", 1)).to.throwError()

    intervalParseShouldReturnIntervalsThatNeverContainsNumber = ->
      sinon.stub(dummyInterval, "contains").returns(false)
      sinon.stub(intervalParserStub, "parse").returns(dummyInterval)

    it "throws exception if number doesn't match multiple choice", ->
      intervalParseShouldReturnAnIntervalThatContainsTheNumber()
      expect(translator.transChoice("id3", 0)).to.be("There is no apples")

    intervalParseShouldReturnAnIntervalThatContainsTheNumber = ->
      sinon.stub(dummyInterval, "contains").returns(true)
      sinon.stub(intervalParserStub, "parse").returns(dummyInterval)