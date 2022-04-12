resource "aws_cloud9_environment_ec2" "this" {
  name                        = var.name
  description                 = var.description
  instance_type               = var.instance_type
  image_id                    = var.image_id
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  connection_type             = var.connection_type
  owner_arn                   = var.owner_arn
  subnet_id                   = var.subnet_id
  tags                        = var.tags
}

data "aws_instance" "this" {
  filter {
    name   = "tag:aws:cloud9:environment"
    values = [aws_cloud9_environment_ec2.this.id]
  }
}

resource "aws_eip" "this" {
  count = var.assign_static_ip ? 1 : 0

  instance = data.aws_instance.this.id
  vpc      = var.vpc
}
