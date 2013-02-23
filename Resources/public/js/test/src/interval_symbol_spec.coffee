describe "IntervalSymbol", ->

  leftIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("[")
  rightIntervalSymbol = new FUNDDY.JsTranslations.IntervalSymbol("]")

  describe "#constructor()", ->

    it "throws exception when symbol is not recognized", ->
      expect(-> new FUNDDY.JsTranslations.IntervalSymbol("")).to.throwError()

  describe "#isLeftOpen()", ->

    it "returns false when symbol is type left", ->
      expect(leftIntervalSymbol.isLeftOpen()).not.to.be.ok()

    it "returns true when symbol is type right", ->
      expect(rightIntervalSymbol.isLeftOpen()).to.be.ok()

  describe "#isLeftClose()", ->

    it "returns true when symbol is type left", ->
      expect(leftIntervalSymbol.isLeftClose()).to.be.ok()

    it "returns false when symbol is type right", ->
      expect(rightIntervalSymbol.isLeftClose()).not.to.be.ok()

  describe "#isRightOpen()", ->

    it "returns true when symbol is type left", ->
      expect(leftIntervalSymbol.isRightOpen()).to.be.ok()

    it "returns false when symbol is type right", ->
      expect(rightIntervalSymbol.isRightOpen()).not.to.be.ok()

  describe "#isRightClose()", ->

    it "returns false when symbol is type left", ->
      expect(leftIntervalSymbol.isRightClose()).not.to.be.ok()

    it "returns true when symbol is type right", ->
      expect(rightIntervalSymbol.isRightClose()).to.be.ok()