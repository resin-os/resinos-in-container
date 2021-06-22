#!/bin/sh

# switch storage driver to overlay2
units="/lib/systemd/system/balena.service"
if [ -f /etc/systemd/system/balena.service.d/balena.conf ]; then
	units="${units} /etc/systemd/system/balena.service.d/balena.conf"
fi
for unit in $units; do
	sed -i "s/-s aufs/-s overlay2/g" "${unit}"
done

# copy device-type.json into the place the supervisor looks for it
cp /resin-boot/device-type.json /mnt/boot/
cp /var/local/boinc.config.json /mnt/boot/config.json

exec /sbin/init
