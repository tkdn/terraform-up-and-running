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
    key            = "live/prod/services/webserver-cluster/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "tkdn-terraform-up-and-running-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "../../../../modules/webserver-cluster"

  ami         = "ami-067983a1f071c98a2"
  server_text = "Hello, New World"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "tkdn-terraform-up-and-running-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}
