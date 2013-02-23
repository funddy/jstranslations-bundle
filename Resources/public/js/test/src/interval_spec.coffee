describe "Interval", ->

  leftIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("[")
  rightIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("]")

  describe "#constructor()", ->

    it "throws exception if left number is higher than right number", ->
      expect(-> new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "20", "10", rightIntervalSymbol))
        .to.throwError()

    it "throws exception while passing invalid format numbers", ->
      invalidNumbers = ["a", "", "-"]
      expect(-> new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, invalidNumber, "10", rightIntervalSymbol))
        .to.throwError() for invalidNumber in invalidNumbers

  describe "#contains()", ->

    interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "3", "5", rightIntervalSymbol)
    excludedStartAndEndInterval = new FUNDDY.JsTranslations.Interval(rightIntervalSymbol, "1", "2", leftIntervalSymbol)

    it "returns true if it contains the number", ->
      expect(interval.contains(4)).to.be.ok()

    it "returns false if it doesn't contain the number", ->
      expect(interval.contains(11)).not.to.be.ok()

    it "doesn't include interval excluded start number", ->
      expect(excludedStartAndEndInterval.contains(1)).not.to.be.ok()

    it "doesn't include interval excluded end number", ->
      expect(excludedStartAndEndInterval.contains(2)).not.to.be.ok()

    it "doesn't contain a lower number than interval start", ->
      expect(interval.contains(2)).not.to.be.ok()

    it "doesn't contain a higher number than interval end", ->
      expect(interval.contains(6)).not.to.be.ok()

    it "negative infinity works", ->
      interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "-Inf", "1", rightIntervalSymbol)
      expect(interval.contains(-100)).to.be.ok()

    it "positive infinity works", ->
      interval = new FUNDDY.JsTranslations.Interval(leftIntervalSymbol, "1", "Inf", rightIntervalSymbol)
      expect(interval.contains(100)).to.be.ok()