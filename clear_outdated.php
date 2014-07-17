<?php
if (!isset($argv[1]) || (!preg_match('#^http://archive.cloudera.com/.+/parcels/latest/$#', $argv[1]) && !preg_match('#^http://archive.cloudera.com/cm#', $argv[1]))) {
    echo <<<USAGE
{$argv[0]} URL
    URL should be like:
        http://archive.cloudera.com/PRODUCT/parcels/latest/
        http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/
        http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/

USAGE;
    exit;
}

$path = __DIR__ . '/' . substr($argv[1], strlen('http://'));
if (strpos($argv[1], 'parcels')) {
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
} else {
    chdir($path);
    $files = glob('*');

    $tree = array();
    foreach ($files as $f) {
        preg_match('#\d#', $f, $m, PREG_OFFSET_CAPTURE);
        if (isset($m[0][1]) && $m[0][1]) {
            $tree[substr($f, 0, $m[0][1])][] = $f;
        }
    }

    foreach ($tree as $f) {
        $keep = max($f);
        foreach ($f as $_f) {
            if ($_f != $keep) {
                echo "Removing file ", $_f, "\n";
                unlink($_f);
            }
        }

    }

}

