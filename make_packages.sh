#!/bin/bash

GST_PACK="/usr/bin/env gst-package"
GST="/usr/bin/env gst"
CURR_DIR=`pwd`
PACK_BUILDER=$CURR_DIR"/PackageBuilder.st"

echo "Packaging in $CURR_DIR ..." > make_packages.log
for i in `find . -name package.st`
do
    echo "creating xml file for $i ..."
	DIR=`dirname $i`
	cd $DIR
	$GST $PACK_BUILDER -a package.st > package.xml
	cd $CURR_DIR

    echo "packaging..."
    $GST_PACK -t ~/.st $DIR/package.xml >> make_packages.log
done

