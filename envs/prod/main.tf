module demo {
  source = "../../modules/demo"
  infra_name = "tfdemo-prod"
  bastion_instance_size = "t2.small"
  server_instance_size = "t2.targe"
}