<?php

$phpVersions = ['5.6', '7.1', '7.2', '7.3', '7.4', '8.0'];

foreach($phpVersions as $phpVersion) {
    $modules = `docker run -it prlx/k8s-openresty-php-php:build--php-$phpVersion php -m`;
    file_put_contents(__DIR__.'/moduleList/'.$phpVersion.'.list', $modules);
}