variable "aws_key_name" {
  description = "Nombre de la clave EC2"
  type        = string
  default     = "keypair-modulo13"
}

variable "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block de la Subnet Pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block de la Subnet Privada"
  type        = string
  default     = "10.0.2.0/24"
}
