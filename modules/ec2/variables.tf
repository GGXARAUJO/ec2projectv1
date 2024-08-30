variable "ami" {
  description = "The (AMI) ID to be used for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create (e.g., t2.micro, t3.large)."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which the EC2 instance will be launched."
  type        = string
}

variable "cliente_nome" {
  description = "The name of the client."
  type        = string
}

variable "regiao" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "tipo_ambiente" {
  description = "The type of environment ( dev, prod, qa) ."
  type        = string
}

variable "instance_name" {
  description = "A specific name for the EC2 instance."
  type        = string
}
variable "key_name" {
  description = "Key pair da conta aws"
  type        = string
}
variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}
