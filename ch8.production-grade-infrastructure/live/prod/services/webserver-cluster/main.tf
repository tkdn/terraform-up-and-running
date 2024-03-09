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
  source = "../../../../modules/services/hello-world-app"

  environment = "production"
  ami         = "ami-019d9da0f68cbf7c0"
  server_text = "Hello, New World"

  db_remote_state_bucket = "tkdn-terraform-up-and-running-state"
  db_remote_state_key    = "live/prod/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}
