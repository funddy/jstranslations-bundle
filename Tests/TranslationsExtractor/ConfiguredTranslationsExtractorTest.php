<?php

namespace Funddy\Bundle\JsTranslationsBundle\Tests\TranslationsExtractor;

use Funddy\Bundle\JsTranslationsBundle\TranslationsExtractor\ConfiguredTranslationsExtractor;
use Mockery as m;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class ConfiguredTranslationsExtractorTest extends \PHPUnit_Framework_TestCase
{
    const IRRELEVANT_LOCALE = 'XX';
    const IRRELEVANT_DOMAIN = 'XXX';
    private static $IRRELEVANT_TRANSLATIONS = array('irrelevant-id' => 'irrelevant-translation');

    private $readableTranslatorMock;
    private $containerMock;
    private $configuredTranslationsExtractor;

    protected function setUp()
    {
        $this->readableTranslatorMock = m::mock('Funddy\Bundle\JsTranslationsBundle\ReadableTranslator\ReadableTranslator');
        $this->containerMock = m::mock('Symfony\Component\DependencyInjection\ContainerInterface');

        $this->configuredTranslationsExtractor = new ConfiguredTranslationsExtractor(
            $this->readableTranslatorMock,
            $this->containerMock
        );
    }

    /**
     * @test
     */
    public function shouldExtractTranslations()
    {
        $this->readableTranslatorLoadLanguageShouldBeCalled();
        $this->containerGetParameterShouldBeCalled();
        $this->readableTranslatorGetCatalogueShouldBeCalled();

        $translations = $this->configuredTranslationsExtractor->extractTranslations(self::IRRELEVANT_LOCALE);

        $this->assertThat($translations, $this->identicalTo(self::$IRRELEVANT_TRANSLATIONS));
    }

    private function readableTranslatorLoadLanguageShouldBeCalled()
    {
        $this->readableTranslatorMock
            ->shouldReceive('loadLanguage')
            ->with(self::IRRELEVANT_LOCALE)->once();
    }

    private function containerGetParameterShouldBeCalled()
    {
        $this->containerMock
            ->shouldReceive('getParameter')
            ->with('funddy.jstranslations.domains')->once()
            ->andReturn(array(self::IRRELEVANT_DOMAIN));
    }

    private function readableTranslatorGetCatalogueShouldBeCalled()
    {
        $this->readableTranslatorMock
            ->shouldReceive('getCatalogue')
            ->with(self::IRRELEVANT_LOCALE)->once()
            ->andReturn($this->createCatalogueMock());
    }

    private function createCatalogueMock()
    {
        $catalogue = m::mock('Symfony\Component\Translation\MessageCatalogue');
        $catalogue
            ->shouldReceive('all')
            ->with(self::IRRELEVANT_DOMAIN)->once()
            ->andReturn(self::$IRRELEVANT_TRANSLATIONS);
        return $catalogue;
    }
}
