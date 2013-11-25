<?php
if (!isset($argv[1]) || !preg_match('#^http://archive.cloudera.com/.+/parcels/latest/$#', $argv[1])) {
	echo "{$argv[0]} http://archive.cloudera.com/PRODUCT/parcels/latest/\n";
	exit;
}

$path = __DIR__ . '/' . substr($argv[1], strlen('http://'));
$jsonfile = $path . 'manifest.json';

if (!is_file($jsonfile)) {
	echo 'manifest.json not found';
	exit;
}
$json = json_decode(file_get_contents($jsonfile), true);
$parcels = array();
foreach ($json['parcels'] as $p) {
	$parcels[] = $p['parcelName'];
}

chdir($path);
$files = glob('*');

foreach ($files as $f) {
	if ($f == 'manifest.json') continue;
	if (!in_array($f, $parcels)) {
		echo "Deleting outdated file {$f}...\n";
		unlink($f);
	}
}
