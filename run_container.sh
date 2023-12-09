#!/bin/bash

# Имя образа
IMAGE_NAME="backup_lib_image"

# Путь к локальному SSH ключу
LOCAL_SSH_KEY="~/.ssh/id_rsa"

# Сборка образа Docker
docker build -t $IMAGE_NAME .

# Запуск Docker контейнера с Volume
docker run -d --rm -v $LOCAL_SSH_KEY:/root/.ssh/id_rsa $IMAGE_NAME