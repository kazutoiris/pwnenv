#!/bin/sh
# DO NOT DELETE
echo $FLAG > /home/ctf/bin/flag && export FLAG=not_flag && FLAG=not_flag
/etc/init.d/xinetd start;
sleep infinity;
