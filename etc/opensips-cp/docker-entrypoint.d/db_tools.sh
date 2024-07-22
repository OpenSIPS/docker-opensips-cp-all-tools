#!/bin/bash

echo "Configuring CP Tools ..."

mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e "
INSERT INTO ocp_tools_config (module, param, value)
SELECT 'user_management', 'passwd_mode', '1'
WHERE NOT EXISTS (
    SELECT 1 FROM ocp_tools_config WHERE module = 'user_management' AND param = 'passwd_mode'
);
"
