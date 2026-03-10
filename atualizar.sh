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

# Limpeza no Navegador
sudo apt clean
sudo apt autoclean
sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
sudo systemd-resolve --flush-caches

rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/Cache/*
rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/Code\ Cache/*
rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/GPUCache/*
rm -rf ~/.config/BraveSoftware/Brave-Browser/
sudo resolvectl flush-caches

rm -rf ~/.cache/mozilla/firefox/*
rm ~/.mozilla/firefox/*default/*.sqlite
rm -rf ~/.cache/chromium/*
rm -rf ~/.config/chromium/Default/*
# Neofetch
sudo apt autoclean -y
sudo apt install neofetch
sudo neofetch
