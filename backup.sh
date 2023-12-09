#!/bin/bash

# Файл для логирования
LOG_FILE="/var/log/cron.log"

echo "Backup script started at $(date)" >> $LOG_FILE

# Загрузка переменных окружения
source .env

echo "Environment variables loaded" >> $LOG_FILE

# Форматирование даты и времени для имени файла
BACKUP_DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILENAME="${BACKUP_DATE}_${MYSQL_DATABASE}_backup.sql"

echo "Backup filename: $BACKUP_FILENAME" >> $LOG_FILE

# Создание дампа MySQL
echo "Starting MySQL dump..." >> $LOG_FILE
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_DATABASE > $BACKUP_FILENAME
echo "MySQL dump completed" >> $LOG_FILE

# Передача файла на удаленный сервер через SSH
echo "Transferring backup to remote server..." >> $LOG_FILE
scp -i $SSH_KEY_PATH $BACKUP_FILENAME $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

if [ $? -eq 0 ]; then
    echo "Backup transfer completed successfully" >> $LOG_FILE
else
    echo "Backup transfer failed" >> $LOG_FILE
fi

# Удаление локального файла дампа
rm $BACKUP_FILENAME
echo "Local backup file removed" >> $LOG_FILE

echo "Backup script finished at $(date)" >> $LOG_FILE

