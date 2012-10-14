root = global ? @
class root.FUNDDY.JsTranslations.Set

  constructor: (@data) ->

  contains: (number) ->
    for dataNumber in @data
      return true if parseInt(dataNumber) is number
    false