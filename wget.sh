#!/bin/sh

WGET="/usr/bin/wget -m" 
PHP=/usr/bin/php
FIND=/usr/bin/find
CURRENT_DIR=`dirname "$0"`
cd $CURRENT_DIR

$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/ --accept-regex='\/4\/' --reject-regex='index\.html'
$WGET  http://archive.cloudera.com/cm4/installer/latest/cloudera-manager-installer.bin 
$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/cloudera-manager.repo

$WGET  http://archive.cloudera.com/cdh4/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/cdh4/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/cdh4/parcels/latest/

$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/ --accept-regex='\/5\/' --reject-regex='index\.html'
$WGET  http://archive.cloudera.com/cm5/installer/latest/cloudera-manager-installer.bin 
$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo

$WGET  http://archive.cloudera.com/cdh5/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/cdh5/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/cdh5/parcels/latest/

# fix cm yum repo link
$PHP fixlink.php cm4 
$PHP fixlink.php cm5

$WGET  http://archive.cloudera.com/search/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/search/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/search/parcels/latest/
$WGET  http://archive.cloudera.com/impala/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/impala/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/impala/parcels/latest/
$WGET  http://archive.cloudera.com/sentry/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/sentry/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/sentry/parcels/latest/
$WGET  http://archive.cloudera.com/gplextras/parcels/latest/ --accept-regex='latest/.*el6.*'
$WGET  http://archive.cloudera.com/gplextras/parcels/latest/manifest.json
$PHP clear_outdated.php http://archive.cloudera.com/gplextras/parcels/latest/

$FIND archive.cloudera.com -name "index.html*" -type f -exec rm -f {} \;

