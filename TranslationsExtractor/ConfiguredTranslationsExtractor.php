<?php

namespace Funddy\Bundle\JsTranslationsBundle\TranslationsExtractor;

use Funddy\Bundle\JsTranslationsBundle\ReadableTranslator\ReadableTranslator;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class ConfiguredTranslationsExtractor implements TranslationsExtractor
{
    private $translator;
    private $container;

    public function __construct(ReadableTranslator $translator, ContainerInterface $container)
    {
        $this->translator = $translator;
        $this->container = $container;
    }

    public function extractTranslations($locale)
    {
        $this->translator->loadLanguage($locale);
        return $this->createTranslations($locale);
    }

    private function createTranslations($locale)
    {
        $translations = array();
        $catalogue = $this->translator->getCatalogue($locale);
        foreach ($this->container->getParameter('funddy.jstranslations.domains') as $domain) {
            $translations = array_merge($translations, $catalogue->all($domain));
        }
        return $translations;
    }
}