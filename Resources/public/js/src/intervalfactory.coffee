root = global ? @
class root.FUNDDY.JsTranslations.IntervalFactory

  constructor: ->

  create: (leftSymbol, leftNumberString, rightNumberString, rightSymbol) ->
    return new root.FUNDDY.JsTranslations.Interval(leftSymbol, leftNumberString, rightNumberString, rightSymbol)