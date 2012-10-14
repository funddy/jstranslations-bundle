root = global ? @
class root.FUNDDY.JsTranslations.Interval

  POSITIVE_INFINITY = "+Inf"
  NEGATIVE_INFINITY = "-Inf"

  constructor: (@leftSymbol, leftNumberString, rightNumberString, @rightSymbol) ->
    @leftNumber = parseNumber(leftNumberString)
    @rightNumber = parseNumber(rightNumberString)

    throw new Error ("Left number must be lower or equal than right one") if @leftNumber > @rightNumber

  contains: (number) ->
    if @numberFitsLeftAndRightConstraints(number)
      return false
    true

  numberFitsLeftAndRightConstraints: (number) ->
    @numberDoesNotFitLeftOpenConstraint(number) or @numberDoesNotFitLeftCloseConstraint(number) or
    @numberDoesNotFitRightOpenConstraint(number) or @numberDoesNotFitRightCloseConstraint(number)

  numberDoesNotFitLeftOpenConstraint: (number) ->
    @leftSymbol.isLeftOpen() and number <= @leftNumber

  numberDoesNotFitLeftCloseConstraint: (number) ->
    @leftSymbol.isLeftClose() and number < @leftNumber

  numberDoesNotFitRightOpenConstraint: (number) ->
    @rightSymbol.isRightOpen() and number >= @rightNumber

  numberDoesNotFitRightCloseConstraint: (number) ->
    @rightSymbol.isRightClose() and number > @rightNumber

  parseNumber = (string) ->
    if (string is POSITIVE_INFINITY)
      return Infinity

    if (string is NEGATIVE_INFINITY)
      return (-Infinity)

    return parseFloat(string)