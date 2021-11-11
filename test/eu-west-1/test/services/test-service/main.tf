variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_name" {
  type = string
}

resource "null_resource" "foo" {
  triggers = {
    aws_account_id = var.aws_account_id
    aws_region     = var.aws_region
    vpc_name       = var.vpc_name
  }
}

output "aws_account_id" {
  value = var.aws_account_id
}

output "aws_region" {
  value = var.aws_region
}

output "vpc_name" {
  value = var.vpc_name
}