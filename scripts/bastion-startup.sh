#!/bin/bash
# environments/dev/scripts/bastion-startup.sh

set -e

# Mise à jour du système
apt-get update
apt-get upgrade -y

# Installation des outils essentiels
apt-get install -y \
    vim \
    htop \
    curl \
    wget \
    git \
    net-tools \
    dnsutils \
    telnet \
    tcpdump

# Installation de gcloud SDK (si pas déjà installé)
if ! command -v gcloud &> /dev/null; then
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    apt-get update && apt-get install -y google-cloud-sdk
fi

# Configuration du timezone
timedatectl set-timezone Europe/Paris

# Activation de la journalisation
systemctl enable systemd-journald
systemctl start systemd-journald

# Message de bienvenue
cat > /etc/motd << 'EOF'
╔════════════════════════════════════════════╗
║       BASTION HOST - ACCÈS SÉCURISÉ        ║
╚════════════════════════════════════════════╝

Cet hôte sert de point d'accès sécurisé pour
l'infrastructure. Toutes les connexions sont
loggées et surveillées.

Pour accéder aux instances:
- Frontend: réseau 10.0.2.0/16
- Backend:  réseau 10.0.3.0/16

EOF

echo "Bastion startup script completed successfully"