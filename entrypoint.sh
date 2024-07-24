#!/bin/bash

  #Transferencia envs POSTGRESQL para todos usuarios
  echo "export POSTGRES_USER='${POSTGRES_USER}'" >> /etc/profile
  echo "export POSTGRES_PASSWORD='${POSTGRES_PASSWORD}'" >> /etc/profile
  echo "export POSTGRES_DB='${POSTGRES_DB}'" >> /etc/profile
  echo "export VISIBLE=now" >> /etc/profile

  service ssh start 

  # Inicializacao repositorio git 
  cd $CASEDIR
  git init 
  git config --global user.name "${GIT_USER_NAME}" 
  git config --global user.email "${GIT_USER_EMAIL}" 
  git remote add origin "${GITREMOTE}"
  git config --global credential.helper store
  echo "https://${GIT_USER_NAME}:${GITHUB_TOKEN}@github.com" > ~/.git-credentials 
  git fetch origin 
  git pull origin dev 

  jupyter notebook --allow-root --no-browser --ip 0.0.0.0 --port 8888


 
