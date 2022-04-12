# Complete Plan Example

```
module "cloud9" {
  source                      = "adamwshero/cloud9/aws"
  version                     = "~> 1.0.0"
  name                        = "my_cloud9"
  description                 = "Description of my_cloud9"
  instance_type               = "t3.micro"
  image_id                    = "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64"
  automatic_stop_time_minutes = 30
  connection_type             = "CONNECT_SSH"
  owner_arn                   = "arn:aws:sts::123456789101112:assumed-role/AWSReservedSSO_AWSAdministratorAccess_a12v456789d123546w"
  subnet_id                   = "subnet-123456789"
  assign_static_ip            = true
  vpc                         = true
  tags = {
    Environment        = local.env
    Owner              = "DevOps"
    CreatedByTerraform = true
  }
}
```
