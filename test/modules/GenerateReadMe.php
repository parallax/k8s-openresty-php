<?php

$phpVersions = (glob(__DIR__ . '/moduleList/*'));

foreach ($phpVersions as $key => $phpVersion) {
	$phpVersions[$key] = str_replace([__DIR__ . '/moduleList/', '.list'], '', $phpVersion);
}


$modules = array();
foreach ($phpVersions as $key => $phpVersion) {
	
	$modules[$phpVersion] = preg_split('/\r\n|\r|\n/', file_get_contents(__DIR__. '/moduleList/' . $phpVersion . '.list'));

	// Filter some lines out
	foreach ($modules[$phpVersion] as $lineKey => $line) {
		if (strstr($line, '[')) {
			unset($modules[$phpVersion][$lineKey]);
		}
	}

}

$allModules = array();
foreach ($phpVersions as $key => $phpVersion) {
	// Filter some lines out
	foreach ($modules[$phpVersion] as $lineKey => $module) {
		if (!isset($allModules[$module])) {
			$allModules[$module] = array();
		}
	}
}

ksort($allModules, SORT_NATURAL | SORT_FLAG_CASE);

// Now add modules for each version
foreach ($allModules as $module => $value) {
	
	foreach ($modules as $phpVersion => $moduleList) {
		foreach ($moduleList as $moduleExistsKey => $moduleExists) {
			if ($moduleExists === $module) {
				$allModules[$module][$phpVersion] = TRUE;
			}
		}
	}
}

// Build the output
$output = '';
$output .= '| Module |';

foreach ($phpVersions as $key => $phpVersion) {
	$output .= ' ' . $phpVersion . ' |';
}
$output .= "\n";
$output .= "| --- |";
foreach ($phpVersions as $key => $phpVersion) {
	$output .= ' --- |';
}
$output .= "\n";
foreach ($allModules as $moduleName => $moduleVersions) {
	$output .= '| ' . $moduleName . ' |';
	foreach ($phpVersions as $key => $phpVersion) {
		if (isset($moduleVersions[$phpVersion])) {
			$output .= ' ✓ |';
		}
		else {
			$output .= ' ✖ |';
		}
	}
	$output .= "\n";
}

//print_r($modules);
$readme = file_get_contents('./README.md.template');
$readme = str_replace('{{ MODULES_TABLE }}', $output, $readme);

file_put_contents('./README.md', $readme);

?>