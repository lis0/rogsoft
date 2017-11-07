#!/bin/sh

#this scripts used for .asusrouer to start httpdb
source /koolshare/scripts/base.sh
mkdir -p /tmp/upload
sh /koolshare/perp/perp.sh
#httpdb >/dev/null 2>&1 &
