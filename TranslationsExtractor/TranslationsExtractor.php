<?php

namespace Funddy\Bundle\JsTranslationsBundle\TranslationsExtractor;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
interface TranslationsExtractor
{
    public function extractTranslations($locale);
}
