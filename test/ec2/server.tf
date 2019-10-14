
resource "aws_instance" "web" {
  count = 1
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  key_name    = "endpoint"
  subnet_id   =  "${element(var.subnets_id,count.index)}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}",
  "${aws_security_group.ALLOW_HTTP.id}"]

  tags = {
    Name = "webserver"
    project_name = "${var.project_name}"
    project_env = "${var.project_env}"
  }
  
  provisioner "remote-exec" {

    connection {
    type     = "ssh"
    user     = "root"
    password = "devops321"
    host     = "${self.public_ip}"
    
  }


    inline = [
      "yum install ansible git -y ",
      "ansible-pull -U https://github.com/lakshmaiah212/practice2.git stack.yml -e DBNAME=studentapp -e DBHOST=${var.DBENDPOINT}
      -e DBUSER=student -e DBPASS=student1" ,
    ]
  }


   


}