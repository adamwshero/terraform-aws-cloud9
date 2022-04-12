output "cloud9_url" {
  description = "Cloud9 Environment URL:"
  value       = "https://${var.region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.this.id}"
}

output "cloud9_connection_type" {
  description = "Cloud9 Connection Type:"
  value       = aws_cloud9_environment_ec2.this.type
}

output "cloud9_arn" {
  description = "Cloud9 Environment Arn:"
  value       = aws_cloud9_environment_ec2.this.arn
}
