describe "Set", ->

  set = new FUNDDY.JsTranslations.Set([3, 2, 1, 4])

  describe "#contains()", ->

    it "returns true if it contains the number", ->
      expect(set.contains(4)).to.be.ok()

    it "returns false if it doesn't contain the number", ->
      expect(set.contains(11)).not.to.be.ok()