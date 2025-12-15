terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  
  default_tags {
    tags = {
      Environment = "Production"
      Project     = "Frontend-CI-CD"
      ManagedBy   = "Terraform"
    }
  }
}