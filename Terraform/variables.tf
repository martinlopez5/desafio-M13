variable "aws_region" {
  description = "Región de AWS"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "Bloque CIDR para la VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "AMI EC2"
  default     = "ami-0c55b159cbfafe1f0" # AMI de Ubuntu 20.04 en us-east-1
}

variable "availability_zone_public" {
  description = "Zona de disponibilidad para la subnet pública"
  default     = "us-east-1a"
}

variable "availability_zone_private" {
  description = "Zona de disponibilidad para la subnet privada"
  default     = "us-east-1b"
}

variable "allowed_ssh_ip" {
  description = "Dirección IP permitida para el ingreso SSH"
  default     = "TU_IP/32"
}