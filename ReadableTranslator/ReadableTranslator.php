<?php

namespace Funddy\Bundle\JsTranslationsBundle\ReadableTranslator;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
interface ReadableTranslator
{
    public function loadLanguage($locale);
}