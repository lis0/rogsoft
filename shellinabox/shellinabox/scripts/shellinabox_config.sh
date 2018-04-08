#!/bin/sh
source /koolshare/scripts/base.sh
eval `dbus export shellinabox`

case $2 in
1)
	if [ "$shellinabox_enable" == "1" ];then
		[ ! -L "/koolshare/init.d/S99shellinabox.sh" ] && ln -sf /koolshare/scripts/shellinabox_config.sh /koolshare/init.d/S99shellinabox.sh
		PID=`pidof shellinaboxd`
		[ -z "$PID" ] && /koolshare/shellinabox/shellinaboxd --css=/koolshare/shellinabox/white-on-black.css -b
		http_response "$1"
	else
		killall shellinaboxd
		http_response "$1"
	fi
	;;
esac
