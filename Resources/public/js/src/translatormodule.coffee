root = global ? @
root.Translator = do ->

  throw new Error("Must define a locale as a variable at global scope 'FUNDDY_JSTRANSLATIONS_LOCALE'") unless root.FUNDDY_JSTRANSLATIONS_LOCALE

  setFactory = new root.FUNDDY.JsTranslations.SetFactory()
  intervalFactory = new root.FUNDDY.JsTranslations.IntervalFactory()
  intervalSymbolFactory = new root.FUNDDY.JsTranslations.IntervalSymbolFactory()
  intervalParser = new root.FUNDDY.JsTranslations.IntervalParser(setFactory, intervalFactory, intervalSymbolFactory)

  translator = new root.FUNDDY.JsTranslations.Translator(
    intervalParser,
    root.FUNDDY.JsTranslations.Translations,
    root.FUNDDY_JSTRANSLATIONS_LOCALE
  )

  trans: translator.trans
  transChoice: translator.transChoice