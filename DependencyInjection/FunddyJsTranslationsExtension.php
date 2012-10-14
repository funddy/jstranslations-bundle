<?php

namespace Funddy\Bundle\JsTranslationsBundle\DependencyInjection;

use Symfony\Component\Config\Definition\Processor;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\DependencyInjection\Loader\YamlFileLoader;
use Symfony\Component\HttpKernel\DependencyInjection\Extension;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class FunddyJsTranslationsExtension extends Extension
{
    public function load(array $configs, ContainerBuilder $container)
    {
        $processor = new Processor();
        $configuration = new Configuration();
        $config = $processor->processConfiguration($configuration, $configs);

        $parameters = array(
            'languages',
            'domains'
        );

        foreach ($parameters as $attribute) {
            $container->setParameter('funddy.jstranslations.'.$attribute, $config[$attribute]);
        }

        $loader = new YamlFileLoader($container, new FileLocator(__DIR__.'/../Resources/config'));
        $loader->load('services.yml');
        $loader->load('controllers.yml');
    }
}
