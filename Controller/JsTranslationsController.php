<?php

namespace Funddy\Bundle\JsTranslationsBundle\Controller;

use Funddy\Bundle\JsTranslationsBundle\TranslationsExporter\JsTranslationsExporter;
use Symfony\Component\HttpFoundation\Response;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class JsTranslationsController
{
    private $jsTranslationsExporter;

    public function __construct(JsTranslationsExporter $jsTranslationsExporter)
    {
        $this->jsTranslationsExporter = $jsTranslationsExporter;
    }

    public function exportAction($locale)
    {
        $response = new Response($this->jsTranslationsExporter->export($locale));
        $response->headers->set('Content-Type', 'text/javascript');
        return $response;
    }
}