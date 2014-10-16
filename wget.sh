#!/bin/bash

WGET="/usr/bin/wget -m" 
PHP=/usr/bin/php
FIND=/usr/bin/find
CURRENT_DIR=`dirname "$0"`

PARCELS=(
    "http://archive.cloudera.com/cdh5/parcels/latest/"
    "http://archive.cloudera.com/gplextras5/parcels/latest/"
	"http://archive.cloudera.com/cm5/installer/latest/"
	"http://archive.cloudera.com/sqoop-connectors/parcels/latest/"

    "http://archive.cloudera.com/cdh4/parcels/latest/"
    "http://archive.cloudera.com/search/parcels/latest/" 
    "http://archive.cloudera.com/impala/parcels/latest/" 
    "http://archive.cloudera.com/sentry/parcels/latest/" 
    "http://archive.cloudera.com/gplextras/parcels/latest/"
    "http://archive.cloudera.com/spark/parcels/latest/"
    "http://archive.cloudera.com/accumulo/parcels/latest/"
	"http://archive.cloudera.com/cm4/installer/latest/"

	"http://archive.cloudera.com/accumulo-c5/parcels/latest/"
)

function download_parcel()
{
    $WGET  $1 --accept-regex='latest/.*el6.*'
    $WGET  $1/manifest.json
    $PHP clear_outdated.php $1
}

cd $CURRENT_DIR

$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/ --accept-regex='\/4\/' --reject-regex='index\.html'
$WGET  http://archive.cloudera.com/cm4/installer/latest/cloudera-manager-installer.bin 
$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
$WGET  http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/cloudera-manager.repo
$PHP clear_outdated.php http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/RPMS/x86_64/ 

$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/ --accept-regex='\/5\/' --reject-regex='index\.html'
$WGET  http://archive.cloudera.com/cm5/installer/latest/cloudera-manager-installer.bin 
$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/RPM-GPG-KEY-cloudera
$WGET  http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo
$PHP clear_outdated.php http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/RPMS/x86_64/


# fix cm yum repo link
$PHP fixlink.php cm4 
$PHP fixlink.php cm5

# Download All parcels
for i in ${PARCELS[@]}; do
    download_parcel $i;
done

$FIND archive.cloudera.com -name "index.html*" -type f -exec rm -f {} \;

