FROM debian:latest

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y cron openssh-client mariadb-client

# Копирование скрипта и файла .env в образ
COPY backup.sh /backup.sh
COPY .env /.env
COPY backup-cron /etc/cron.d/backup-cron

# Выдача прав на выполнение скрипта
RUN chmod +x /backup.sh
RUN chmod 0644 /etc/cron.d/backup-cron

# Создание лог файла для cron
RUN touch /var/log/cron.log

# Запуск cron
CMD ["cron", "-f"]
