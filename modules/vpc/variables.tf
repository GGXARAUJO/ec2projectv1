variable "cliente_nome" {
  description = "Nome do cliente para a VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block para a VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block para a subnet pública"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone para a subnet"
  type        = string
}

variable "enable_dns_support" {
  description = "Habilitar DNS supportss"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames"
  type        = bool
  default     = true
}
