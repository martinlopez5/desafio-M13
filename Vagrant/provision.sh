#!/bin/bash

# Actualiza el sistema e instala las herramientas necesarias
sudo apt-get update
sudo apt-get install -y unzip python3-pip

# Instala Terraform
TERRAFORM_VERSION="1.5.7"  # Cambia la versión de Terraform según sea necesario
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Instala Ansible
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
python3 -m pip install ansible

# Clonar Repo, con archivos Terraform y Ansible
git clone https://github.com/martinlopez5/desafio-M13.git

#Copiar archivo .tfvars a carpeta Terraform
sudo cp /vagrant/terraform.tfvars /home/vagrant/desafio-M13/Terraform
sudo cp /vagrant/keypair-modulo13.pem /home/vagrant/desafio-M13/Terraform

#Moverme a directorio Terraform
sudo chmod 777 /home/vagrant/desafio-M13/Terraform/keypair-modulo13.pem
