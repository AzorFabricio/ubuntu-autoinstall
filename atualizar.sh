#!/bin/bash
sudo apt-get update -y
sudo apt update -y
sudo apt-get upgrade -y
sudo apt upgrade -y
sudo apt update && sudo apt upgrade -y
sudo apt autoremove
# Remove pacotes desnecessários
sudo apt autoremove -y
# Limpa o cache de pacotes
# Limpa a lixeira.
sudo rm -rf /home/$USER/.local/share/Trash/files/*
# Limpa arquivos temporários.
sudo rm -rf /var/tmp/*
# Limpa o cache do apt-get.
sudo apt-get clean -y
# Remove repositórios inuteis.
sudo apt-get autoremove -y
# Remove pacotes obsoletos.
sudo apt-get autoclean -y
# Repara pacotes quebrados.
sudo dpkg --configure -a

sudo apt autoclean -y
sudo apt install neofetch
sudo neofetch
