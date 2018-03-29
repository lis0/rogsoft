#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
MODEL=`nvram get model`
enable=`dbus get aria2_enable`

if [ "$aria2_enable" == "1" ];then
	[ -f "/koolshare/scripts/aria2_config.sh"] && sh /koolshare/scripts/aria2_config.sh stop
fi

cp -rf /tmp/aria2/bin/* /koolshare/bin/
cp -rf /tmp/aria2/scripts/* /koolshare/scripts/
cp -rf /tmp/aria2/webs/* /koolshare/webs/
cp -rf /tmp/aria2/res/* /koolshare/res/
cp -rf /tmp/aria2/uninstall.sh /koolshare/scripts/uninstall_aria2.sh
if [ "$MODEL" == "GT-AC5300" ];then
	cp -rf /tmp/aria2/GT-AC5300/webs/* /koolshare/webs/
fi
rm -fr /tmp/aria2* >/dev/null 2>&1
chmod +x /koolshare/bin/*
chmod +x /koolshare/scripts/aria2*.sh
chmod +x /koolshare/scripts/uninstall_aria2.sh
[ !-L "/koolshare/init.d/M99Aria2.sh" ] && ln -sf /koolshare/scripts/aria2_config.sh /koolshare/init.d/M99Aria2.sh
[ !-L "/koolshare/init.d/N99Aria2.sh" ] && ln -sf /koolshare/scripts/aria2_config.sh /koolshare/init.d/N99Aria2.sh

dbus set aria2_version="1.0"
dbus set softcenter_module_aria2_install=1
dbus set softcenter_module_aria2_name="aria2"
dbus set softcenter_module_aria2_title="aria2"
dbus set softcenter_module_aria2_description="linux下载利器"
sleep 1

if [ "$aria2_enable" == "1" ];then
	[ -f "/koolshare/scripts/aria2_config.sh"] && sh /koolshare/scripts/aria2_config.sh start
fi

