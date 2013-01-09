<?php

namespace Funddy\Bundle\JsTranslationsBundle\ReadableTranslator;

use Symfony\Bundle\FrameworkBundle\Translation\Translator;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class SymfonyReadableTranslator extends Translator implements ReadableTranslator
{
    public function getCatalogue($locale)
    {
        foreach ($this->catalogues as $catalogue) {
            if ($catalogue->getLocale() === $locale) {
                return $catalogue;
            }
        }
        throw new CatalogueNotFound($locale);
    }

    public function loadLanguage($locale)
    {
        $this->loadCatalogue($locale);
    }
}