#!/bin/bash
set -euo pipefail

# Amazon Linux 2023
dnf update -y

# Install Docker + git
dnf install -y docker git

systemctl enable docker
systemctl start docker

# Docker Compose v2 plugin (best-effort)
dnf install -y docker-compose-plugin || true

# Allow ec2-user to run docker without sudo
usermod -aG docker ec2-user

# Create a standard folder for deployments
mkdir -p /opt/monitoring
chmod 755 /opt/monitoring
