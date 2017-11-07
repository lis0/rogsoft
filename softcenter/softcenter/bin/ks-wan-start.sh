#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh


echo start `date` > /tmp/ks_wan_log.txt
# set ks_nat to 1, incase of nat start twice at the same time when booting system or ks-wan-start.sh and ks-nat-start.sh been trigered at the same time.
# because when software start by wan, they start nat when nat is ready.
nvram set ks_nat="1"

# -----------------------------
ACTION=$1

if [ $# -lt 1 ]; then
    printf "Usage: $0 {start|stop|restart|reconfigure|check|kill}\n" >&2
    exit 1
fi

[ $ACTION = stop -o $ACTION = restart -o $ACTION = kill ] && ORDER="-r"

for i in $(find /koolshare/init.d/ -name 'S*' | sort $ORDER ) ;
do
    case "$i" in
        S* | *.sh )
            # Source shell script for speed.
            trap "" INT QUIT TSTP EXIT
            #set $1
            logger "plugin_log_1 $i"
            if [ -r "$i" ]; then
            . $i $ACTION
            fi
            ;;
        *)
            # No sh extension, so fork subprocess.
            logger "plugin_log_2 $i"
            $i $ACTION
            ;;
    esac
done
# -----------------------------

# set ks_nat to 0 after system boot finished,
# when system triger only the firewall restart, incase of some software's nat been flushed, set ks_nat to 0,
# the ks-nat-start.sh will start /jffs/koolshare/inin.d/N*.sh to reload software's nat.
nvram set ks_nat="0"
echo finish `date` >> /tmp/ks_wan_log.txt
