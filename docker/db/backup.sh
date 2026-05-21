#!/bin/sh
mysqldump -uroot -p"$MARIADB_ROOT_PASSWORD" --all-databases > /var/lib/mysql/backup.sql
