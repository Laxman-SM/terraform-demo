resource "aws_instance" "bastion_host"{
  ami = "${data.aws_ami.debian_ami.image_id}"
  instance_type = "${var.bastion_instance_size}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  key_name = "${aws_key_pair.keypair.key_name}"
  vpc_security_group_ids = [
    "${aws_vpc.vpc.default_security_group_id}",
    "${aws_security_group.ssh_security_group.id}"
  ]
  tags {
    Name  = "${var.infra_name}_bastion_host"
  }
}

resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id = "${aws_instance.bastion_host.id}"
  allocation_id = "${aws_eip.bastion_host_ip.id}"
}