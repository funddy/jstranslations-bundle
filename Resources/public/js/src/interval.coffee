class FUNDDY.JsTranslations.Interval

  POSITIVE_INFINITY = "Inf"
  NEGATIVE_INFINITY = "-Inf"
  NUMBER_PATTERN = /\d+/

  constructor: (@leftSymbol, leftNumberString, rightNumberString, @rightSymbol) ->
    @leftNumber = parseNumber(leftNumberString)
    @rightNumber = parseNumber(rightNumberString)

    throw new Error ("Left number must be lower or equal than right one") if @leftNumber > @rightNumber

  contains: (number) ->
    not @numberDoesNotFitLeftAndRightConstraints(number)

  numberDoesNotFitLeftAndRightConstraints: (number) ->
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
    return Infinity if (string is POSITIVE_INFINITY)
    return (-Infinity) if (string is NEGATIVE_INFINITY)
    assertNumber(string)
    parseFloat(string)

  assertNumber = (string) ->
    throw new Error("#{string} is not a number") unless NUMBER_PATTERN.test(string)