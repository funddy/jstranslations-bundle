class FUNDDY.JsTranslations.IntervalSymbol

  LEFT_TYPE = "["
  RIGHT_TYPE = "]"

  constructor: (@symbol) ->
    if @symbol isnt LEFT_TYPE and @symbol isnt RIGHT_TYPE
      throw new Error("Symbol #{@symbol} not recognized")

  isLeftOpen: ->
    @symbol is RIGHT_TYPE

  isLeftClose: ->
    @symbol is LEFT_TYPE

  isRightOpen: ->
    @symbol is LEFT_TYPE

  isRightClose: ->
    @symbol is RIGHT_TYPE
