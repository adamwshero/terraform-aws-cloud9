locals {
  account     = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  sso_admin   = "arn:aws:iam::{accountid}:role/my_trusted_role"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

terraform {
  source = "git@github.com:adamwshero/terraform-aws-cloud9.git//?ref=1.0.4"
}

inputs = {
  name                        = "my_cloud9"
  description                 = "Description of my_cloud9"
  instance_type               = "t3.micro"
  image_id                    = "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64"
  automatic_stop_time_minutes = 30
  connection_type             = "CONNECT_SSH"
  owner_arn                   = "local.sso_admin"
  subnet_id                   = dependency.vpc.outputs.public_subnets[1]
  assign_static_ip            = true
  vpc                         = true
  tags = {
    Environment        = local.env.locals.env
    Owner              = "DevOps"
    CreatedByTerraform = true
  }
}
