<?php

namespace Funddy\Bundle\JsTranslationsBundle\DependencyInjection;

use Symfony\Component\Config\Definition\Builder\TreeBuilder;
use Symfony\Component\Config\Definition\ConfigurationInterface;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class Configuration implements ConfigurationInterface
{
    public function getConfigTreeBuilder()
    {
        $treeBuilder = new TreeBuilder();
        $rootNode = $treeBuilder->root('funddy_js_routing');

        $rootNode
            ->children()
                ->arrayNode('languages')
                ->isRequired()
                    ->prototype('scalar')->end()
                ->end()
                ->arrayNode('domains')
                ->isRequired()
                    ->prototype('scalar')->end()
                ->end()
            ->end();

        return $treeBuilder;
    }
}
