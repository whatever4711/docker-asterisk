#!/bin/bash
ASTERISKUSER=$1

# Compile and Install Asterisk
curl -sf -o asterisk.tar.gz -L http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz
mkdir asterisk
tar -xzf /usr/src/asterisk.tar.gz -C /usr/src/asterisk --strip-components=1
rm asterisk.tar.gz
cd asterisk
./configure
contrib/scripts/get_mp3_source.sh
make menuselect.makeopts
sed -i "s/format_mp3//" menuselect.makeopts
sed -i "s/BUILD_NATIVE//" menuselect.makeopts
make
make install
make config
ldconfig
update-rc.d -f asterisk remove
rm -r /usr/src/asterisk

# Download extra sounds
cd /var/lib/asterisk/sounds
curl -sf -o asterisk-core-sounds-en-wav-current.tar.gz -L http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz
tar -xzf asterisk-core-sounds-en-wav-current.tar.gz
rm -f asterisk-core-sounds-en-wav-current.tar.gz
curl -sf -o asterisk-extra-sounds-en-wav-current.tar.gz -L http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz
tar -xzf asterisk-extra-sounds-en-wav-current.tar.gz
rm -f asterisk-extra-sounds-en-wav-current.tar.gz
curl -sf -o asterisk-core-sounds-en-g722-current.tar.gz -L http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz
tar -xzf asterisk-core-sounds-en-g722-current.tar.gz
rm -f asterisk-core-sounds-en-g722-current.tar.gz
curl -sf -o asterisk-extra-sounds-en-g722-current.tar.gz -L http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz
tar -xzf asterisk-extra-sounds-en-g722-current.tar.gz
rm -f asterisk-extra-sounds-en-g722-current.tar.gz

# Add Asterisk user
useradd -m $ASTERISKUSER
chown $ASTERISKUSER. /var/run/asterisk
chown -R $ASTERISKUSER. /etc/asterisk
chown -R $ASTERISKUSER. /var/lib/asterisk
chown -R $ASTERISKUSER. /var/log/asterisk
chown -R $ASTERISKUSER. /var/spool/asterisk
chown -R $ASTERISKUSER. /usr/lib/asterisk
chown -R $ASTERISKUSER. /var/www/
chown -R $ASTERISKUSER. /var/www/*
rm -rf /var/www/html
