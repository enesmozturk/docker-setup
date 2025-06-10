#!/bin/bash

# Sistem güncelle
sudo apt update && sudo apt upgrade -y

# Gerekli paketleri kur
sudo apt install -y ca-certificates curl gnupg lsb-release git

# Docker GPG key ve repo ekle
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker'ı kur
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Docker servisini başlat ve enable et
sudo systemctl enable docker
sudo systemctl start docker

# Mevcut kullanıcıyı docker grubuna ekle (logout/login sonrası etkili olur)
sudo usermod -aG docker $USER

#Docker kurulum sonrası kurulan docker versiyonlarını gösterme
docker --version
docker compose version
systemctl status docker

# (Opsiyonel) Git repo'yu klonla
# git clone https://github.com/kullanici/proje.git /home/$USER/proje

# Projeye gir ve docker-compose çalıştır
# cd /home/$USER/proje
# docker compose up --build -d
