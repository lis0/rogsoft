#! /bin/sh
MODEL=`nvram get model`

cd /tmp
cp -rf /tmp/qiandao/qiandao /koolshare/
cp -rf /tmp/qiandao/res/* /koolshare/res/
cp -rf /tmp/qiandao/scripts/* /koolshare/scripts/
cp -rf /tmp/qiandao/webs/* /koolshare/webs/
if [ "$MODEL" == "GT-AC5300" ];then
	cp -rf /tmp/aria2/GT-AC5300/webs/* /koolshare/webs/
fi
cp -rf /tmp/qiandao/uninstall.sh /koolshare/scripts/uninstall_qiandao.sh
rm -rf /tmp/qiandao* >/dev/null 2>&1
rm -rf /koolshare/init.d/*qiandao.sh
sleep 1
[ ! -L "/koolshare/init.d/S99qiandao.sh" ] && ln -sf /koolshare/scripts/qiandao_config.sh /koolshare/init.d/S99qiandao.sh
chmod 755 /koolshare/qiandao/*
chmod 755 /koolshare/init.d/*
chmod 755 /koolshare/scripts/qiandao*

