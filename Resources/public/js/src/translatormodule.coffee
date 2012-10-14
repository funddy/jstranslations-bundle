@Translator = (->

  if (typeof(FUNDDY_JSTRANSLATIONS_LOCALE) is "undefined")
    throw new Error("Must define a locale as a variable at global scope 'FUNDDY_JSTRANSLATIONS_LOCALE'")

  setFactory = new FUNDDY.JsTranslations.SetFactory()
  intervalFactory = new FUNDDY.JsTranslations.IntervalFactory()
  intervalSymbolFactory = new FUNDDY.JsTranslations.IntervalFactory()
  intervalParser = new FUNDDY.JsTranslations.IntervalParser(setFactory, intervalFactory, intervalSymbolFactory)

  translator = new FUNDDY.JsTranslations.Translator(
    intervalParser,
    FUNDDY.JsTranslations.Translations,
    FUNDDY_JSTRANSLATIONS_LOCALE
  )

  return {
    trans: translator.trans
    transChoice: translator.transChoice
  }
)()