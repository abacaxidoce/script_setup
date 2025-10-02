#!/bin/bash

set -e

echo "========================="
echo " Atualizando o sistema"
echo "========================="
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gpg wget lsb-release sudo

echo "========================="
echo " Instalando o Docker"
echo "========================="

# Adiciona a chave GPG do Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório do Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker instalado com sucesso."

echo "========================="
echo " Instalando o Mise"
echo "========================="

sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list > /dev/null
sudo apt update -y
sudo apt install -y mise

echo "Mise instalado com sucesso."

echo "========================="
echo " Instalando o Git"
echo "========================="
sudo apt install -y git
echo "Git instalado com sucesso."

echo "========================="
echo " Todos os pacotes foram instalados com sucesso!"
echo "========================="
