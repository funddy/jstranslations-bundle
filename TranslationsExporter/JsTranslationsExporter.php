<?php

namespace Funddy\Bundle\JsTranslationsBundle\TranslationsExporter;

use Funddy\Bundle\JsTranslationsBundle\TranslationsExtractor\TranslationsExtractor;
use Symfony\Bundle\FrameworkBundle\Templating\EngineInterface;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class JsTranslationsExporter
{
    private $translationsExtractor;
    private $jsonSerializer;
    private $templateEngine;

    public function __construct(
        TranslationsExtractor $translationsExtractor,
        SerializerInterface $jsonSerializer,
        EngineInterface $templateEngine
    )
    {
        $this->translationsExtractor = $translationsExtractor;
        $this->jsonSerializer = $jsonSerializer;
        $this->templateEngine = $templateEngine;
    }

    public function export($locale)
    {
        $translations =  $this->translationsExtractor->extractTranslations($locale);
        $serializedTranslations = $this->jsonSerializer->serialize($translations, 'json');

        return $this->templateEngine->render(
            'FunddyJsTranslationsBundle:JsTranslations:translations.js.twig',
            array('translations' => $serializedTranslations, 'locale' => $locale)
        );
    }
}
