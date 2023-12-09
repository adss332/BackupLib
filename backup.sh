#!/bin/bash

# Загрузка переменных окружения
source .env

# Форматирование даты и времени для имени файла
BACKUP_DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILENAME="${BACKUP_DATE}_${MYSQL_DATABASE}_backup.sql"

# Создание дампа MySQL
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_DATABASE > $BACKUP_FILENAME

# Передача файла на удаленный сервер через SSH
scp -i $SSH_KEY_PATH $BACKUP_FILENAME $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

# Удаление локального файла дампа
rm $BACKUP_FILENAME
