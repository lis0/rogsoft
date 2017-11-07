#!/bin/sh

softcenter_install() {
	if [ -d "/tmp/softcenter" ]; then
		# make some folders
		mkdir -p /jffs/configs/dnsmasq.d
		mkdir -p /jffs/etc
		mkdir -p /jffs/scripts
		mkdir -p /koolshare/bin/
		mkdir -p /koolshare/init.d/
		mkdir -p /koolshare/scripts/
		mkdir -p /koolshare/configs/
		mkdir -p /koolshare/webs/
		mkdir -p /koolshare/res/
		mkdir -p /tmp/upload
		# coping files
		cp -rf /tmp/softcenter/webs/* /koolshare/webs/
		cp -rf /tmp/softcenter/res/* /koolshare/res/
		cp -rf /tmp/softcenter/init.d/* /koolshare/init.d/
		cp -rf /tmp/softcenter/bin/* /koolshare/bin/
		cp -rf /tmp/softcenter/perp /koolshare/
		cp -rf /tmp/softcenter/scripts /koolshare/
		chmod 755 /koolshare/bin/*
		chmod 755 /koolshare/init.d/*
		chmod 755 /koolshare/perp/*
		chmod 755 /koolshare/perp/.boot/*
		chmod 755 /koolshare/perp/.control/*
		chmod 755 /koolshare/perp/httpdb/*
		chmod 755 /koolshare/perp/skipd/*
		chmod 755 /koolshare/scripts/*
		
		# remove install package
		rm -rf /tmp/softcenter
		# make some link
		[ ! -L "/koolshare/bin/base64_decode" ] && ln -sf /koolshare/bin/base64_encode /koolshare/bin/base64_decode
		[ ! -L "/koolshare/bin/base64" ] && ln -sf /bin/busybox /koolshare/bin/base64
		[ ! -L "/koolshare/scripts/ks_app_remove.sh" ] && ln -sf /koolshare/scripts/ks_app_install.sh /koolshare/scripts/ks_app_remove.sh
		[ ! -L "/jffs/.asusrouter" ] && ln -sf /koolshare/bin/kscore.sh /jffs/.asusrouter
		[ ! -L "/jffs/etc/profile" ] && ln -sf /koolshare/scripts/base.sh /jffs/etc/profile

		# creat wan-start and nat-start when not exist
		if [ ! -f "/jffs/scripts/wan-start" ];then
			cat > /jffs/scripts/wan-start <<-EOF
			#!/bin/sh
			/koolshare/bin/ks-wan-start.sh start
			EOF
			chmod +x /jffs/scripts/wan-start
		fi
		if [ ! -f "/jffs/scripts/nat-start" ];then
			cat > /jffs/scripts/nat-start <<-EOF
			#!/bin/sh
			/koolshare/bin/ks-nat-start.sh start_nat
			EOF
			chmod +x /jffs/scripts/nat-start
		fi

		# now try to reboot httpdb if httpdb not started
		if [ -z "`pidof httpdb`"];then
			sh /koolshare/perp/perp.sh
		fi
		#PERP_PROCESS=`pidof perpboot`
		#if [ -z "$PERP_PROCESS" ];then
		#	sh /koolshare/bin/kscore.sh
		#else
		#	PERP=`perpls | grep -E "httpdb|\+\+" | wc -l`
		#	[ "$PERP" -ne "1" ] && sh /koolshare/bin/kscore.sh || echo software center runing normally!
		#fi
	fi
}

softcenter_install
