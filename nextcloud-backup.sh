#!/bin/sh


MYSQL_USERNAME=''

MYSQL_PASSWORD=''

MYSQL_DATABASE=''

MYSQL_SAVE_PATH=''

HOSTNAME=''

SERVER_USERNAME=''

NC_DATA_SOURCE_PATH=''

NC_DATA_DESCTINATION_PATH=''

#probably stupid idea
SUDO_PASSWORD=''

 echo ${SUDO_PASSWORD} | ssh ${SERVER_USERNAME}@${HOSTNAME} 'cd /var/www/nextcloud; sudo -S -u www-data php occ maintenance:mode --on;'

mysqldump --single-transaction -u ${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -h ${HOSTNAME} ${MYSQL_DATABASE} | gzip > ${MYSQL_SAVE_PATH}nextcloud-database-`date +"%H:%M:%S-%d-%m-%Y"`.sql.gz


rsync -azP ${SERVER_USERNAME}@${HOSTNAME}:${NC_DATA_SOURCE_PATH} ${NC_DATA_DESCTINATION_PATH}



echo ${SUDO_PASSWORD} | ssh  ${SERVER_USERNAME}@${HOSTNAME} 'cd /var/www/nextcloud; sudo -S -u www-data php occ maintenance:mode --off;'
