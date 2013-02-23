window.Translator = do ->

  DEFAULT_LOCALE = "en"

  throw new Error("Must define translations as a variable at global scope 'TRANSLATIONS'") unless window.TRANSLATIONS

  setFactory = new FUNDDY.JsTranslations.SetFactory()
  intervalFactory = new FUNDDY.JsTranslations.IntervalFactory()
  intervalSymbolFactory = new FUNDDY.JsTranslations.IntervalSymbolFactory()
  intervalParser = new FUNDDY.JsTranslations.IntervalParser(setFactory, intervalFactory, intervalSymbolFactory)

  locale = if (window.TRANSLATIONS_LOCALE) then window.TRANSLATIONS_LOCALE else DEFAULT_LOCALE
  translator = new FUNDDY.JsTranslations.Translator(intervalParser, window.TRANSLATIONS, locale)

  trans: translator.trans
  transChoice: translator.transChoice