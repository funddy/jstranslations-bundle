// Generated by CoffeeScript 1.4.0
(function() {

  describe("Set", function() {
    var set;
    set = new FUNDDY.JsTranslations.Set([3, 2, 1, 4]);
    return describe("#contains()", function() {
      it("returns true if it contains the number", function() {
        return expect(set.contains(4)).to.be.ok();
      });
      return it("returns false if it doesn't contain the number", function() {
        return expect(set.contains(11)).not.to.be.ok();
      });
    });
  });

}).call(this);
