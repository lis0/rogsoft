#!/bin/sh

# this scripts used for .asusrouer to start httpdb
source /koolshare/scripts/base.sh
mkdir -p /tmp/upload
sh /koolshare/perp/perp.sh
#httpdb >/dev/null 2>&1 &

#============================================
# check start up scripts 
if [ ! -f "/jffs/scripts/wan-start" ];then
	cat > /jffs/scripts/wan-start <<-EOF
	#!/bin/sh
	/koolshare/bin/ks-wan-start.sh start
	EOF
	chmod +x /jffs/scripts/wan-start
else
	STARTCOMAND1=`cat /jffs/scripts/wan-start | grep ks-wan-start`
	[ -z "$STARTCOMAND1" ] && sed -i '2a /koolshare/bin/ks-wan-start.sh start' /jffs/scripts/wan-start
fi

if [ ! -f "/jffs/scripts/nat-start" ];then
	cat > /jffs/scripts/nat-start <<-EOF
	#!/bin/sh
	/koolshare/bin/ks-nat-start.sh start_nat
	EOF
	chmod +x /jffs/scripts/nat-start
else
	STARTCOMAND2=`cat /jffs/scripts/nat-start | grep ks-nat-start`
	[ -z "$STARTCOMAND2" ] && sed -i '2a /koolshare/bin/ks-nat-start.sh start' /jffs/scripts/nat-start
fi

if [ ! -f "/jffs/scripts/post-mount" ];then
	cat > /jffs/scripts/post-mount <<-EOF
	#!/bin/sh
	/koolshare/bin/ks-mount-start.sh start
	EOF
	chmod +x /jffs/scripts/post-mount
else
	STARTCOMAND2=`cat /jffs/scripts/post-mount | grep ks-mount-start`
	[ -z "$STARTCOMAND2" ] && sed -i '2a /koolshare/bin/ks-mount-start.sh start' /jffs/scripts/post-mount
fi
#============================================
