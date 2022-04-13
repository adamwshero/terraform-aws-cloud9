######################
# Cloud 9 Environment
######################
variable "name" {
  description = "(Required) The name of the environment."
  type        = string
  default     = ""
}

variable "description" {
  description = "(Required) The type of instance to connect to the environment, e.g., t2.micro."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "(Optional) The connection type used for connecting to an Amazon EC2 environment. Valid values are CONNECT_SSH and CONNECT_SSM."
  type        = string
  default     = "t3.micro"
}

variable "image_id" {
  description = "(Optional) The identifier for the Amazon Machine Image (AMI) that's used to create the EC2 instance."
  type        = string
  default     = "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64"
  validation {
    condition = contains([
      "amazonlinux-1-x86_64",
      "amazonlinux-2-x86_64",
      "ubuntu-18.04-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-1-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/ubuntu-18.04-x86_64"
    ], var.image_id)
    error_message = "ImageId invalid. Please choose a valid image_id."
  }
}

variable "automatic_stop_time_minutes" {
  description = "(Optional) The number of minutes until the running instance is shut down after the environment has last been used."
  type        = number
  default     = 30
}

variable "connection_type" {
  description = "(Optional) The connection type used for connecting to an Amazon EC2 environment. Valid values are CONNECT_SSH and CONNECT_SSM."
  type        = string
  default     = "CONNECT_SSH"
}

variable "owner_arn" {
  description = "(Optional) The ARN of the environment owner. This can be ARN of any AWS IAM principal. Defaults to the environment's creator."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "(Optional) The ID of the subnet in Amazon VPC that AWS Cloud9 will use to communicate with the Amazon EC2 instance."
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS Region where your chosen subnet resides (Only used to build the cloud9_url in outputs)."
  default     = "us-east-1"
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
}

##############
# Cloud 9 EIP
##############

variable "assign_static_ip" {
  description = "Controls whether or not an EIP is created and assigned to the Cloud9 Environment."
  type        = bool
  default     = false
}

variable "vpc" {
  description = "(Optional) Boolean if the EIP is in a VPC or not."
  type        = bool
  default     = false
}
