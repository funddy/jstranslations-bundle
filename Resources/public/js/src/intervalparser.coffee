root = global ? @
class root.FUNDDY.JsTranslations.IntervalParser

  FIRST_CHARACTER_POSITION = 0
  SECOND_CHARACTER_POSITION = 1
  OPENING_SET_CHARACTER = "{"
  CLOSING_SET_CARACTER = "}"
  SET_PATTERN = /^\{-?\d+(,-?\d+)*\}/
  INTERVAL_PATTERN = /^[\[\]]-?(\d+|Inf),-?(\d+|Inf)[\[\]]/
  SEPARATOR_CHARACTER = ","

  constructor: (@setFactory, @intervalFactory, @intervalSymbolFactory) ->

  parse: (string) ->
    return @createSetFromString(string) if stringIsLikeASet(string)
    return @createIntervalFromString(string) if stringIsLikeAnInteval(string)
    throw new Error("Parse error in string '#{string}'")

  stringIsLikeASet = (string) ->
    SET_PATTERN.test(string)

  stringIsLikeAnInteval = (string) ->
    INTERVAL_PATTERN.test(string)

  createSetFromString: (string) ->
    string = string + ""
    interval = string.substr(1, string.length - 2)
    data = interval.split(SEPARATOR_CHARACTER)
    return @setFactory.create(data)

  createIntervalFromString: (string) ->
    parts = string.split(SEPARATOR_CHARACTER)
    leftPart = parts[0]
    rightPart = parts[1]

    leftNumberText = leftPart.substr(SECOND_CHARACTER_POSITION)
    rightNumberText = rightPart.substr(FIRST_CHARACTER_POSITION, rightPart.length - 1)
    rightSymbol = @intervalSymbolFactory.create(rightPart[rightPart.length - 1])
    leftSymbol = @intervalSymbolFactory.create(leftPart[FIRST_CHARACTER_POSITION])

    @intervalFactory.create(leftSymbol, leftNumberText, rightNumberText, rightSymbol)
