resource "aws_db_instance" "dev_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  name                 = "studentapp-db"
  username             = "student"
  password             = "student1"
  parameter_group_name = "${aws_db_parameter_group.rds_parametergroup.name}"
  db_subnet_group_name  = "${aws_db_subnet_group.rds_subnet_group.name}"
  skip_final_snapshot    = true
  identifier            = "student-rds-mariadb"
  vpc_security_group_ids = ["${aws_security_group.mysql.id}"]
}