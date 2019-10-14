resource "aws_subnet" "public_subnets" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 3, count.index)}"

  tags = {
    Name = "publicsubnets-${count.index}"
  }
}

resource "aws_route_table" "publicsubnet_routetable" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }


  tags = {
    Name = "publicsubnet_route_table"
  }
}

resource "aws_route_table_association" "public_Subnet_association" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.publicsubnet_routetable.id}"
}


resource "aws_subnet" "private_subnets" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id     = "${aws_vpc.test_vpc.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 3, count.index+3)}"

  tags = {
    Name = "privatesubnets-${count.index}"
  }
}

resource "aws_route_table" "privatesubnet_routetable" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  tags = {
    Name = "privatesubnet_route_table"
  }
}

resource "aws_route_table_association" "private_Subnet_association" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.privatesubnet_routetable.id}"
}