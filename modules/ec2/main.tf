
resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "${var.cliente_nome}-AWS-${var.regiao}-${var.tipo_ambiente}-${var.instance_name}"
  }
  key_name      = var.key_name
}
