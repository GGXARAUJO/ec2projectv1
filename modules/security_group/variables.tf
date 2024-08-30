variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "A description for the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "A list of maps containing ingress rules"
  type        = list(map(any))
}

variable "egress_rules" {
  description = "A list of maps containing egress rules"
  type        = list(map(any))
}
