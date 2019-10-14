resource "aws_instance" "mariadb-client" {
  count = 1
  ami           = "ami-04763b3055de4860b"
  instance_type = "t2.micro"
  key_name    = "endpoint"
  subnet_id   =  "${element(var.subnets_id,count.index)}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  tags = {
    Name = "mariadb_client"
    project_name = "${var.project_name}"
    project_env = "${var.project_env}"
  }


   provisioner "file" {
    connection {
    type     = "ssh"
    user     = "root" 
    host     = "${self.public_ip}"
  }
    source      = "rds/schema.sql"
    destination = "/tmp/schema.sql"
  }

  
  provisioner "remote-exec" {

    connection {
    type     = "ssh"
    user     = "root"
    host     = "${self.public_ip}"
    
  }


    inline = [
      "yum install mariadb -y ",
      "mysql -h ${aws_db_instance.dev_rds.address} -u student -p student1 </tmp/schema.sql",
    ]
  }
  
}