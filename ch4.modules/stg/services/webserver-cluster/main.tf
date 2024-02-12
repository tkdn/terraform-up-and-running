provider "aws" {
  region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "git@github.com:tkdn/terraform-up-and-running.git//ch4.modules/modules/webserver-cluster?ref=v0.0.1"

  cluster_name           = "webservers-stg"
  db_remote_state_bucket = "tkdn-terraform-up-and-running-state"
  db_remote_state_key    = "stg/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}
