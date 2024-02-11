provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    # バケット
    bucket = "tkdn-terraform-up-and-running-state"
    key    = "workspace-exmaple/terraform.tfstate"
    region = "ap-northeast-1"
    # DynamoDB
    dynamodb_table = "tkdn-terraform-up-and-running-locks"
    encrypt        = true
  }
}
