root = global ? @
class root.FUNDDY.JsTranslations.Translator

  MULTIPLE_CHOICES_SEPARATOR = "|"
  INTERVAL_SEPARATOR = " "

  constructor: (@intervalParser, @translations, @locale) ->
    @checkLocaleExists()

  checkLocaleExists: ->
    throw new Error("There are no transactions with locale '#{@locale}'") unless (@locale of @translations)

  trans: (id, parameters = {}) ->
    translation = @findTranslation(id)
    replaceParametersWithValues(translation, parameters)

  findTranslation: (id) ->
    @checkIdExists(id)
    @translations[@locale][id]

  checkIdExists: (id) ->
    throw new Error("No transaction found for id '#{id}'") unless (id of @translations[@locale])

  replaceParametersWithValues = (text, parameters) ->
    for index, parameter of parameters
      text = text.replace(index, parameter)
    text

  transChoice: (id, number, parameters = {}) ->
    translation = @findTranslation(id)
    choices = splitIntoChoices(translation)
    return @selectAndProcessChoice(choices, number, parameters)

  splitIntoChoices = (translation) ->
    parts = translation.split(MULTIPLE_CHOICES_SEPARATOR)
    choices = {}
    for part in parts
      pos = part.indexOf(INTERVAL_SEPARATOR)
      intervalData = part.substr(0, pos)
      choices[intervalData] = part.substr(pos + 1)
    choices

  selectAndProcessChoice: (choices, number, parameters) ->
    for intervalData, translation of choices
      interval = @intervalParser.parse(intervalData)
      if (interval.contains(number))
        return replaceParametersWithValues(translation, parameters)

    throw new Error("No translation found for id '#{id}' number '#{number}'")