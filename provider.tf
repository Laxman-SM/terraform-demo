provider "aws" {}

resource "aws_key_pair" "keypair"{
  key_name = "${var.infra_name}_keypair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

