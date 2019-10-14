resource "aws_db_parameter_group" "rds_parametergroup" {
  name   = "rds-pg"
  family = "mariadb10.3"

parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
  
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_publicsubnet_group"
  subnet_ids = "${var.subnets_id}"

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "mysql" {
  name        = "mysql_traffic"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}