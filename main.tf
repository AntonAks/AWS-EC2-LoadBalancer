terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Output Load Balancer URL
output "load_balancer_url" {
  value = aws_lb.http_lb.dns_name
}