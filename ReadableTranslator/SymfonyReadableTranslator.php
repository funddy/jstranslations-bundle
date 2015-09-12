<?php

namespace Funddy\Bundle\JsTranslationsBundle\ReadableTranslator;

use Symfony\Bundle\FrameworkBundle\Translation\Translator;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class SymfonyReadableTranslator extends Translator implements ReadableTranslator
{
    public function loadLanguage($locale)
    {
        $this->loadCatalogue($locale);
    }
}