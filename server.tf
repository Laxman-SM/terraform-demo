resource "aws_instance" "server" {
  ami = "${data.aws_ami.debian_ami.image_id}"
  instance_type = "${var.server_instance_size}"
  subnet_id = "${aws_subnet.private_subnet.id}"
  key_name = "${aws_key_pair.keypair.key_name}"
  vpc_security_group_ids = [
    "${aws_vpc.vpc.default_security_group_id}"
  ]
  tags {
    Name  = "${var.infra_name}_server"
  }
  user_data = <<EOF
#!/bin/bash
apt-get update -y && apt-get install -y nginx
EOF
  count = 2
}
