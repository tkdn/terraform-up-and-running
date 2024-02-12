provider "aws" {
  region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "../../../modules/webserver-cluster"

  cluster_name           = "webservers-stg"
  db_remote_state_bucket = "tkdn-terraform-up-and-running-state"
  db_remote_state_key    = "stg/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}
