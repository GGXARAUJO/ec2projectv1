variable "cliente_nome" {
  description = "Nome do cliente para prefixar nas instâncias EC2"
  type        = string
  
}
variable "regiao" {
  description = "Regiao onde o ambiente vai estar localizado Exemplo: UE1, SA1"
  type        = string
  
}
variable "tipo_ambiente" {
  description = "Tipo de ambiente Exemplo: DEV, PROD, QA"
  type        = string
  
}
variable "cliente_nome_inteiro" {
  description = "Nome Inteiro do cliente"
  type        = string
  
}

variable "key_name" {
  description = "Key pair do ec2 da aws"
  type        = string
  
}