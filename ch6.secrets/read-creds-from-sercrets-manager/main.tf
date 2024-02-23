provider "aws" {
  region = "ap-northeast-1"
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "db-creds"
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}

output "creds_username" {
  sensitive = true
  value     = local.db_creds.username
}

output "creds_password" {
  sensitive = true
  value     = local.db_creds.password
}
