variable vpc_cidr_block {
  type = "string"
  default = "10.254.0.0/16"
}

variable infra_name {
  type = "string"
  default = "tfdemo"
}

variable public_subnet_cidr {
  type = "string"
  default = "10.254.10.0/24"
}

variable private_subnet_cidr {
  type = "string"
  default = "10.254.20.0/24"
}

variable bastion_instance_size {
  type = "string"
  default = "t2.nano"
}

variable server_instance_size {
  type = "string"
  default = "t2.small"
}
