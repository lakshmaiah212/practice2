resource "aws_vpc" "test_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "test_vpc"
    project_name = "${var.project_name}"
    project_env = "${var.project_env}"
    created_with = "terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  tags = {
    Name = "igw"
  }
}