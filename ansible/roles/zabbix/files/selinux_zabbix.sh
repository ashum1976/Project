#!/usr/bin/env bash
cd /root
if [[ ! -e /root/zabbix_server_add.pp && -e /root/zabbix_server_add.te ]]
    then
        checkmodule -M -m  ./zabbix_server_add.te -o ./zabbix_server_add.mod
        semodule_package -m ./zabbix_server_add.mod -o ./zabbix_server_add.pp
        semodule -i ./zabbix_server_add.pp

fi
