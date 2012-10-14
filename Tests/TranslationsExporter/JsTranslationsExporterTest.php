<?php

namespace Funddy\Bundle\JsTranslationsBundle\Tests\TranslationsExporter;

use Funddy\Bundle\JsTranslationsBundle\TranslationsExporter\JsTranslationsExporter;
use Mockery as m;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class JsTranslationsExporterTest extends \PHPUnit_Framework_TestCase
{
    const IRRELEVANT_LOCALE = 'XX';
    const IRRELEVANT_TRANSLATIONS = 'XXX';
    const IRRELEVANT_SERIALIZED_TRANSLATIONS = 'XXXX';
    const IRRELEVANT_JS_EXPORT = 'XXXXX';

    private $translationsExtractorMock;
    private $serializerMock;
    private $templateEngineMock;
    private $jsTranslationsExporter;

    protected function setUp()
    {
        $this->translationsExtractorMock = m::mock('Funddy\Bundle\JsTranslationsBundle\TranslationsExtractor\TranslationsExtractor');
        $this->serializerMock = m::mock('Symfony\Component\Serializer\SerializerInterface');
        $this->templateEngineMock = m::mock('Symfony\Bundle\FrameworkBundle\Templating\EngineInterface');

        $this->jsTranslationsExporter = new JsTranslationsExporter(
            $this->translationsExtractorMock,
            $this->serializerMock,
            $this->templateEngineMock
        );
    }

    /**
     * @test
     */
    public function shouldExportThroughServices()
    {
        $this->translationsExtractorExtractTranslationsShouldBeCalled();
        $this->serializerSerializeShouldBeCalled();
        $this->templateEngineRenderShouldBeCalled();

        $this->assertThat(
            $this->jsTranslationsExporter->export(self::IRRELEVANT_LOCALE),
            $this->identicalTo(self::IRRELEVANT_JS_EXPORT)
        );
    }

    private function translationsExtractorExtractTranslationsShouldBeCalled()
    {
        $this->translationsExtractorMock
            ->shouldReceive('extractTranslations')
            ->with(self::IRRELEVANT_LOCALE)->once()
            ->andReturn(self::IRRELEVANT_TRANSLATIONS);
    }

    private function serializerSerializeShouldBeCalled()
    {
        $this->serializerMock
            ->shouldReceive('serialize')
            ->with(self::IRRELEVANT_TRANSLATIONS, 'json')->once()
            ->andReturn(self::IRRELEVANT_SERIALIZED_TRANSLATIONS);
    }

    private function templateEngineRenderShouldBeCalled()
    {
        $this->templateEngineMock
            ->shouldReceive('render')
            ->with(
                'FunddyJsTranslationsBundle:JsTranslations:translations.js.twig',
                array(
                    'translations' => self::IRRELEVANT_SERIALIZED_TRANSLATIONS,
                    'locale' => self::IRRELEVANT_LOCALE
                )
            )->once()
            ->andReturn(self::IRRELEVANT_JS_EXPORT);
    }
}
