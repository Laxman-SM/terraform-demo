resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
    Name = "${var.infra_name}_vpc"
  }
}

resource "aws_eip" "nat_gw_ip" {
  vpc = true
}

resource "aws_eip" "bastion_host_ip" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.infra_name}_igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"

  tags {
    Name = "${var.infra_name}_public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"

  tags {
    Name = "${var.infra_name}_private_subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.infra_name}_public_rt"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }
  tags {
    Name = "${var.infra_name}_private_rt"
  }
}
resource "aws_route_table_association" "private_association" {
  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private.id}"
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_gw_ip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
}



