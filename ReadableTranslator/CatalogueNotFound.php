<?php

namespace Funddy\Bundle\JsTranslationsBundle\ReadableTranslator;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class CatalogueNotFound extends \RuntimeException
{
    public function __construct($locale)
    {
        parent::__construct(sprintf('Catalogue with locale "%s" was not found', $locale));
    }
}