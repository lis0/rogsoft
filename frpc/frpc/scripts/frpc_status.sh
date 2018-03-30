#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

frpc_pid=`pidof frpc`

if [ -n "$frpc_pid" ];then
    http_response "frpc 0.16.0 进程运行正常！PID：$frpc_pid"
else
    http_response "frpc 进程未运行！"
fi
