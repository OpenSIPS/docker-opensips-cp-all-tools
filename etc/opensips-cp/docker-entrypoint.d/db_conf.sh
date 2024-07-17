#!/bin/bash
echo "Configuring OpenSIPS Control Panel ..."

sed -i "s/localhost/${MYSQL_IP}/g" /var/www/html/opensips-cp/config/db.inc.php

sed -i "s/127.0.0.1/${OPENSIPS_IP}/g" /var/www/html/opensips-cp/config/db_schema.mysql

TABLE_EXISTS=$(mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -e "SHOW TABLES LIKE 'ocp_admin_privileges';" -D ${MYSQL_DATABASE})

if [ -z "$TABLE_EXISTS" ]; then
    mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} < /var/www/html/opensips-cp/config/db_schema.mysql
fi

mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e "
INSERT INTO rtpengine (socket, set_id)
SELECT 'udp:${RTPENGINE_IP}:${RTPENGINE_PORT}', 0
WHERE NOT EXISTS (
    SELECT 1 FROM rtpengine WHERE socket = 'udp:${RTPENGINE_IP}:${RTPENGINE_PORT}'
);"

mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e "
INSERT INTO rtpproxy_sockets (rtpproxy_sock, set_id)
SELECT 'udp:${RTPPROXY_IP}:${RTPPROXY_PORT}', 0
WHERE NOT EXISTS (
    SELECT 1 FROM rtpproxy_sockets WHERE rtpproxy_sock = 'udp:${RTPPROXY_IP}:${RTPPROXY_PORT}'
);"
