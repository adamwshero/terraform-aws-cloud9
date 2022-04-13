[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

![Terraform](https://cloudarmy.io/tldr/images/tf_aws.jpg)
<br>
<br>
<br>
<br>
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/adamwshero/terraform-aws-cloud9?color=lightgreen&label=latest%20tag%3A&style=for-the-badge)
<br>
<br>
# terraform-aws-cloud9-environment-ec2

Terraform module to create Amazon Cloud9 EC2 Development Environment with an optional elastic IP (EIP).

[AWS Cloud9](https://aws.amazon.com/cloud9/) is a cloud-based integrated development environment (IDE) that lets you write, run, and debug your code with just a browser. It includes a code editor, debugger, and terminal. Cloud9 comes prepackaged with essential tools for popular programming languages, including JavaScript, Python, PHP, and more, so you don’t need to install files or configure your development machine to start new projects. Since your Cloud9 IDE is cloud-based, you can work on your projects from your office, home, or anywhere using an internet-connected machine. Cloud9 also provides a seamless experience for developing serverless applications enabling you to easily define resources, debug, and switch between local and remote execution of serverless applications. With Cloud9, you can quickly share your development environment with your team, enabling you to pair program and track each other's inputs in real time.

## Examples

Look at our [Terraform example](latest/examples/terraform/) where you can get a better context of usage for both Terraform. The Terragrunt example can be viewed directly from GitHub.

## Usage

You can create a single Cloud9 environment with an optional elastic IP assigned to it that is inside our outside of your VPC.

\* NOTE: Resources in this module can cost money to deploy and maintain. Size your Cloud9 instances that fit within your budget. \*

### Terraform Example

```
module "cloud9" {

  source = "adamwshero/cloud9/aws"
  version = "~> 1.0.5"

  name              = "test_cloud9"
  description       = "Description of my_cloud9"
  subnet_id         = "subnet-123456abcd789"
  assign_static_ip  = true
  vpc               = true
  tags = {
      application      = "my-service"
      environment      = "dev"
      last_modified_by = "devops.hero@company.com"
      team_name        = "devops"
  }
}
```

### Terragrunt Example

```
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
  source = "git@github.com:adamwshero/terraform-aws-cloud9.git//?ref=1.0.5"
}

inputs = {
  name             = "my_cloud9"
  description      = "Description of my_cloud9"
  subnet_id        = dependency.vpc.outputs.public_subnets[1]
  assign_static_ip = true
  vpc              = true
  tags             = local.tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.67.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.67.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ksm_key.rsm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Available Inputs

| Name                | Resource                   | Variable                     | Data Type     | Default                                                     |Required?|
| --------------------| ---------------------------| -----------------------------| --------------|-------------------------------------------------------------|---------|
| Name                | aws_cloud9_environment_ec2 | `name`                       | `string`      | `""`                                                        | Yes     |
| Description         | aws_cloud9_environment_ec2 | `description`                | `string`      | `""`                                                        | No      |
| Instance Type       | aws_cloud9_environment_ec2 | `instance_type`              | `string`      | `t3.micro`                                                  | Yes     |
| Image Id            | aws_cloud9_environment_ec2 | `image_id`                   | `string`      | `resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64` | No      |
| Automatic Stop Time | aws_cloud9_environment_ec2 | `automatic_stop_time_minutes`| `number`      | `30`                                                        | No      |
| Connection Type     | aws_cloud9_environment_ec2 | `connection_type`            | `string`      | `CONNECT_SSH`                                               | No      |
| Owner Arn           | aws_cloud9_environment_ec2 | `owner_arn`                  | `string`      | `""`                                                        | No      |
| Subnet Id           | aws_cloud9_environment_ec2 | `subnet_id`                  | `string`      | `""`                                                        | No      |
| Region              | aws_cloud9_environment_ec2 | `region`                     | `string`      | `us-east-1`                                                 | No      |
| Tags                | aws_cloud9_environment_ec2 | `tags`                       | `map(string)` | `""`                                                        | No      |
| Assign Static IP    | aws_eip                    | `assign_static_ip`           | `bool`        | `false`                                                     | No      |
| vpc                 | aws_eip                    | `vpc`                        | `bool`        | `false`                                                     | No      |

## Outputs

| Name         | Description                                             |
|--------------|---------------------------------------------------------|
| Cloud9 Arn             | Arn of the Cloud9 Environment.                |
| Cloud9 Connection Type | Connection type of the Cloud9 Environment.    |
| Cloud9 Public IP       | Static IP assigned to the Cloud9 Environment. |
| Cloud9 URL             | URL of the Cloud9 Environment.                |

