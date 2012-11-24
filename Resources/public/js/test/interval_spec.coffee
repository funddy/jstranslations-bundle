chai = require "chai"
expect = chai.expect
should = chai.should()
sinon = require "sinon"

require "#{__dirname}/../src/namespaces"
require "#{__dirname}/../src/intervalsymbol"
require "#{__dirname}/../src/interval"

describe "Interval", ->

  leftIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("[")
  rightIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("]")

  describe "#constructor()", ->

    it "throws exception if left number is higher than right number", ->
      expect(-> new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "20", "10", rightIntervalSymbol)).to.throw(Error)

    it "throws exception while passing invalid format numbers", ->
      invalidNumbers = ["a", "", "-"]
      expect(-> new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, invalidNumber, "10", rightIntervalSymbol)).to.throw(Error) for invalidNumber in invalidNumbers

  describe "#contains()", ->

    interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "3", "5", rightIntervalSymbol)
    excludedStartAndEndInterval = new FUNDDY.JsTranslations.Interval(rightIntervalSymbol, "1", "2", leftIntervalSymbol)

    it "returns true if it contains the number", ->
      interval.contains(4).should.equal(true)

    it "returns false if it doesn't contain the number", ->
      interval.contains(11).should.equal(false)

    it "doesn't include interval excluded start number", ->
      excludedStartAndEndInterval.contains(1).should.equal(false)

    it "doesn't include interval excluded end number", ->
      excludedStartAndEndInterval.contains(2).should.equal(false)

    it "doesn't contain a lower number than interval start", ->
      interval.contains(2).should.equal(false)

    it "doesn't contain a higher number than interval end", ->
      interval.contains(6).should.equal(false)

    it "negative infinity works", ->
      interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "-Inf", "1", rightIntervalSymbol)
      interval.contains(-100).should.equal(true)

    it "positive infinity works", ->
      interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "1", "Inf", rightIntervalSymbol)
      interval.contains(100).should.equal(true)

