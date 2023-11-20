# Configura el proveedor AWS
provider "aws" {
}

# Crea una VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

# Crea una Subnet Pública
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Crea una Subnet Privada
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = "us-east-1b"
}

# Crea una instancia EC2 en la Subnet Pública
resource "aws_instance" "backend_instance" {
  ami             = "ami-0c55b159cbfafe1f0"  # Debes reemplazar esto con la AMI de Ubuntu
  instance_type   = "t2.micro"
  key_name        = var.aws_key_name
  subnet_id       = aws_subnet.public_subnet.id

# Configuración del volumen EBS
root_block_device {
  volume_type           = "gp2"
  volume_size           = 8  # Tamaño del volumen en GB
  delete_on_termination = true

  # Puedes personalizar más opciones según tus necesidades
}
}

# Output para obtener la IP pública de la instancia
output "backend_instance_public_ip" {
  value = aws_instance.backend_instance.public_ip
}
