provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./modules/vpc"
  cliente_nome       = var.cliente_nome
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

module "ec2_appserver" {
  source         = "./modules/ec2"
  ami            = ""
  instance_type  = "t3.xlarge"
  subnet_id      = module.vpc.public_subnet_id
  cliente_nome   = var.cliente_nome
  regiao         = var.regiao
  tipo_ambiente  = var.tipo_ambiente
  instance_name  = "AS01"
  security_group_ids  = [aws_security_group.sg_appserver.id]
  key_name      = var.key_name
}

module "ec2_mysql" {
  source         = "./modules/ec2"
  ami            = ""
  instance_type  = "i4i.xlarge"
  subnet_id      = module.vpc.public_subnet_id
  cliente_nome   = var.cliente_nome
  regiao         = var.regiao
  tipo_ambiente  = var.tipo_ambiente
  instance_name  = "MYSQL01"
  security_group_ids  = [aws_security_group.sg_mysql.id]
  key_name      = var.key_name

}

resource "aws_eip" "appserver_eip" {
  instance = module.ec2_appserver.instance_id
  tags = {
    Name = "${var.cliente_nome}-AppServer-EIP"
  }
}

resource "aws_eip" "mysql_eip" {
  instance = module.ec2_mysql.instance_id
  tags = {
    Name = "${var.cliente_nome}-MySQL-EIP"
  }
}

resource "aws_security_group" "sg_appserver" {
  name        = "${var.cliente_nome}-sg-appserver"
  description = "Security group for App Server - ${var.cliente_nome}"
  vpc_id      = module.vpc.vpc_id

  # Zabbix Server

  # RDP
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Web Deploy
  ingress {
    from_port   = 8172
    to_port     = 8172
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "sg_mysql" {
  name        = "${var.cliente_nome}-sg-mysql"
  description = "Security group for MySQL Server - ${var.cliente_nome}"
  vpc_id      = module.vpc.vpc_id

# MySQL
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Alternative MySQL
  ingress {
    from_port   = 33060
    to_port     = 33060
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Zabbix

  # ICMP (ping)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_record" "appserver_record" {
  zone_id = ""
  name    = "${var.cliente_nome_inteiro}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.appserver_eip.public_ip]
}

resource "aws_route53_record" "mysql_record" {
  zone_id = ""
  name    = "db.${var.cliente_nome_inteiro}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.mysql_eip.public_ip]
}
