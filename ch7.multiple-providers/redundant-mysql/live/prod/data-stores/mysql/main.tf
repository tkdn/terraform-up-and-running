terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1" #東京
  alias  = "primary"
}

provider "aws" {
  region = "ap-northeast-2" #ソウル
  alias  = "replica"
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.primary
  }

  db_name     = "prod_db"
  db_username = var.db_password
  db_password = var.db_password

  backup_retension_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.replica
  }

  replica_sourece_db = module.mysql_primary.arn
}
