data aws_ami "debian_ami" {
  most_recent = true
  name_regex = "debian-jessie-amd64-hvm-.*-ebs"
}