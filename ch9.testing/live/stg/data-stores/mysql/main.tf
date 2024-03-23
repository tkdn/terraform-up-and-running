terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tkdn-terraform-up-and-running-state"
    key            = "live/stg/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "tkdn-terraform-up-and-running-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"

  db_name     = "example_database_staging"
  db_username = var.db_username
  db_password = var.db_password
}
