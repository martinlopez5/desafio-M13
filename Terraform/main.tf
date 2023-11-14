# Configuración del proveedor AWS
provider "aws" {
  region = var.aws_region
}

# Recurso VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

# Subnet pública
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.vpc_cidr_block
  availability_zone = var.availability_zone_public
  map_public_ip_on_launch = true
}

# Subnet privada
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.vpc_cidr_block
  availability_zone = var.availability_zone_private
}

# Grupo de seguridad
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "My Security Group"

  # Regla para permitir el acceso SSH desde una dirección IP específica
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  # Agrega más reglas según sea necesario
}

# Instancia EC2
resource "aws_instance" "my_instance" {
  ami           = var.ec2_ami # AMI de Ubuntu 20.04 en us-east-1
  instance_type = var.instance_type

  subnet_id          = aws_subnet.public_subnet.id
  security_groups    = [aws_security_group.my_security_group.name]
  associate_public_ip_address = true

  # Puedes agregar más configuraciones de instancia según tus necesidades
}
