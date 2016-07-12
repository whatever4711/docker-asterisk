#!/bin/bash

# Download and install FreePBX
curl -sf -o freepbx.tgz -L http://mirror.freepbx.org/modules/packages/freepbx/freepbx-13.0-latest.tgz
tar xfz freepbx.tgz
rm freepbx.tgz
cd /usr/src/freepbx
/etc/init.d/mysql start
mkdir /var/www/html
/etc/init.d/apache2 start
/usr/sbin/asterisk
sleep 5
./install -n
fwconsole restart
rm -r /usr/src/freepbx
