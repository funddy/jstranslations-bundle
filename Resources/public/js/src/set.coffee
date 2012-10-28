root = global ? @
class root.FUNDDY.JsTranslations.Set

  constructor: (@data) ->

  contains: (number) ->
    for dataNumber in @data
      return parseInt(dataNumber) is number
    false