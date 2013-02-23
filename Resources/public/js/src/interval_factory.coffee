class FUNDDY.JsTranslations.IntervalFactory

  constructor: ->

  create: (leftSymbol, leftNumberString, rightNumberString, rightSymbol) ->
    return new FUNDDY.JsTranslations.Interval(leftSymbol, leftNumberString, rightNumberString, rightSymbol)