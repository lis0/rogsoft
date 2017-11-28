#!/bin/sh

alias echo_date='echo $(date +%Y年%m月%d日\ %X)'
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export swap_`

case $1 in
start)
	#if [ -n $swap_auto_mount ] && [ -f $swap_auto_mount ];then
		logger "[软件中心]: 启动swap！"
		logger "[软件中心]: $swap_auto_mount"
		logger "[软件中心]: `ls /tmp/mnt`"
		swapon $swap_auto_mount
	#fi
	;;
esac
