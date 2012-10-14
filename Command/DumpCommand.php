<?php

namespace Funddy\Bundle\JsTranslationsBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * @copyright (C) Funddy (2012)
 * @author Keyvan Akbary <keyvan@funddy.com>
 */
class DumpCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('funddy:jstranslations:dump')
            ->setDefinition(array(
                new InputArgument('target', InputArgument::OPTIONAL, 'The target path', 'web/js/'),
            ))
            ->setDescription('Export configured translations into JavaScript file')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $target = $input->getArgument('target');
        $exporter = $this->getContainer()->get('funddy.jstranslations.service.jstranslationsexporter');

        foreach($this->getContainer()->getParameter('funddy.jstranslations.languages') as $locale) {
            $filePath = $target.'translations.'.$locale.'.js';
            if (@file_put_contents($filePath, $exporter->export($locale)) === false) {
                throw new \RuntimeException(sprintf('Unable to write file "%s"', $filePath));
            }

            $output->writeln(sprintf('Wrote <comment>%s</comment>', $filePath));
        }
    }
}
