# JavaScript Translations Bundle

[![Build Status](https://secure.travis-ci.org/funddy/jstranslations-bundle.png?branch=master)](http://travis-ci.org/funddy/jstranslations-bundle)

This bundle enables you to use your Symfony translator from JavaScript, allowing the generate translations in a very
similar way.

## Setup and Configuration
First, you should have the Translator enabled at `app/config.yml`
```yaml
framework:
    translator: { fallback: en }
```

Add the following to your `composer.json` file:
```json
{
    "require": {
        "funddy/jstranslations-bundle": "2.0.*"
    }
}
```

Update the vendor libraries:

    curl -s http://getcomposer.org/installer | php
    php composer.phar install

Register the Bundle FunddyJsTranslationsBundle in `app/AppKernel.php`.
```php
public function registerBundles()
{
    $bundles = array(
        new Funddy\Bundle\JsTranslationsBundle\FunddyJsTranslationsBundle()
    );
}
```

For finishing, override the default translator with one which implements the ReadableTranslator interface at
`app/parameters.yml` file
```yaml
parameters:
    translator.class: Funddy\Bundle\JsTranslationsBundle\ReadableTranslator\SymfonyReadableTranslator
```

## Usage
Expose the translations that you want to have accessible from your JavaScript code adding the languages and domains to
the bundle configuration
```yaml
funddy_js_translations:
    languages: [es, en]
    domains: [messages]
```
Now it's time to decide whether you want to use static or dynamic generated translations.

### Dynamic Translations
This is the most flexible option. Every time you make a change in translations you'll be able to access them from
JavaScript. It's ideal for development environment or for those cases where you performance is not an issue. As
everything in life, you have to pay a price, which is invoking an URL to regenerate all translations every time you make a
request.

Include FunddyJsTranslationsBundle routing at `app/routing.yml`
```yaml
jstranslations:
    resource: "@FunddyJsTranslationsBundle/Resources/config/routing.yml"
```

Include the scripts
```html
<script>var TRANSLATIONS_LOCALE = "{{ app.request.locale }}"</script>
<script src="{{ path('funddy_jstranslations', {locale: app.request.locale}) }}"></script>
<script src="{{ asset('bundles/funddyjstranslations/js/lib/funddytranslations.js') }}"></script>
```

### Static Translations
Is the best solution when we talk about performance, include compiled translations in order to avoid controller
execution.

Compile the translations

    php app/console funddy:jstranslations:dump

Include translations
```html
<script>var TRANSLATIONS_LOCALE = '{{ app.request.locale }}'</script>
<script src="{{ asset('js/translations.' ~ app.request.locale ~ '.js') }}"></script>
<script src="{{ asset('bundles/funddyjstranslations/js/lib/funddytranslations.js') }}"></script>
```

### Have fun!
```html
<script>
    console.log(Translator.trans('Hello %name%!', {'%name%': 'Charlie'})); //Hello Charlie!
    console.log(Translator.transChoice('{1} There is one apple|]1,19] There are %count% apples', 3, {'%count%': 3}));//There are 3 apples
</script>
```

## Defining Your Own Translator
What if you do not want to use the default "Translator" global var and define your own? Easy, include only translations
runtime and define your own translator.
```html
<script src="{{ path('funddy_jstranslations', {locale: app.request.locale}) }}"></script>
<script src="{{ asset('bundles/funddyjstranslations/js/lib/funddytranslations.js') }}"></script>
<script>
    var LOCALE = '{{ app.request.locale }}';
    var MyOwnTranslator = (function() {
        var translator =
            new FUNDDY.JsTranslations.Translator(
                new FUNDDY.JsTranslations.IntervalParser(
                    new FUNDDY.JsTranslations.SetFactory(),
                    new FUNDDY.JsTranslations.IntervalFactory(),
                    new FUNDDY.JsTranslations.IntervalSymbolFactory()
                ),
                TRANSLATIONS, LOCALE
            );

        return {
            trans: translator.trans
            transChoice: translator.transChoice
        };
    })();

    console.log(MyOwnTranslator.trans('Hello %name%!', {'%name%': 'Charlie'}));//Hello Charlie!
</script>
```
