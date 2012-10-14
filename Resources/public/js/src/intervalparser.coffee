root = global ? @
class root.FUNDDY.JsTranslations.IntervalParser

  FIRST_CHARACTER_POSITION = 0
  SECOND_CHARACTER_POSITION = 1
  OPENING_SET_CHARACTER = "{"
  SEPARATOR_CHARACTER = ","

  constructor: (@setFactory, @intervalFactory, @intervalSymbolFactory) ->

  parse: (string) ->
    return @createSetFromString(string) if stringIsLikeASet(string)
    @createIntervalFromString(string)

  stringIsLikeASet = (string) ->
    string[FIRST_CHARACTER_POSITION] is OPENING_SET_CHARACTER

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
