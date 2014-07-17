<?php
$domain = 'archive.cloudera.com';

if (!isset($argv[1])) {
    echo "{$argv[0]} cm4|cm5 \n";
    exit;
}

if ($argv[1] == 'cm4') {
    $path = '/cm4/redhat/6/x86_64/cm/';
    $compare_with = '4';
} else if ($argv[1] == 'cm5') {
    $path = '/cm5/redhat/6/x86_64/cm/';
    $compare_with = '5';
}

$web_contents = file_get_contents('http://' . $domain . $path);
preg_match_all('#<a href="([\d\.a-z\-]+)/">([\d\.a-z\-]+)/</a>#', $web_contents, $m);

@chdir(__DIR__ . '/' . $domain . $path);
foreach ($m[2] as $k=>$v) {
    if ($v === $compare_with) {
        continue;
    }
    $name = $v;
    @unlink($name);
    symlink($compare_with, $name);
}

