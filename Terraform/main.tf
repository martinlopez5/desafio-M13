# Crea una VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-modulo13"
  }
}

# Crea un Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Crea una Subnet Pública
resource "aws_subnet" "public_subnet" {
  count                   = 1
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-modulo13"
  }
}

# Crea una Tabla de Ruteo para la Subnet Pública
resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "public-subnet-route-table-modulo13"
  }
}

# Asocia la Tabla de Ruteo a la Subnet Pública
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet[0].id
  route_table_id = aws_route_table.public_subnet.id
}

# Configura la Regla de Ruta en la Tabla de Ruteo de la Subnet Pública
resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.public_subnet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Crea una Subnet Privada
resource "aws_subnet" "private_subnet" {
  count                   = 1
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "private-subnet-modulo13"
  }
}

resource "aws_security_group" "backend_security_group" {
  name = "backend-security-group"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-modulo13"
  }
}

resource "aws_instance" "backend_instance" {
  ami             = "ami-06aa3f7caf3a30282"
  instance_type   = "t2.micro"
  key_name        = var.aws_key_name
  subnet_id       = aws_subnet.public_subnet[0].id  # Accede a la primera instancia con [0]
  security_groups = [aws_security_group.backend_security_group.id]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "ec2-modulo13"
  }
}

# Output para obtener la IP pública de la instancia
output "backend_instance_public_ip" {
  value = aws_instance.backend_instance.public_ip
}
