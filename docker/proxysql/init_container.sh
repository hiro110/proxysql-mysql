#!/bin/sh

envsubst < /tmp/proxysql.cnf.template > /etc/proxysql.cnf
cat /etc/proxysql.cnf

proxysql -f --idle-threads -c /etc/proxysql.cnf