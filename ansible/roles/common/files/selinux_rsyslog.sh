#!/usr/bin/env bash
cd /root
if [[ ! -e /root/syslog_audit.pp && -e /root/syslog_audit.te ]]
    then
        checkmodule -M -m  ./syslog_audit.te -o ./syslog_audit.mod
        semodule_package -m ./syslog_audit.mod -o ./syslog_audit.pp
        semodule -i ./syslog_audit.pp

fi
