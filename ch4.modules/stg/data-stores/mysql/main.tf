provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_db_instance" "exmaple" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = "example_database"

  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    bucket         = "tkdn-terraform-up-and-running-state"
    key            = "stg/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "tkdn-terraform-up-and-running-locks"
    encrypt        = true
  }
}

# 例えばテストでStagingにのみ追加でポートを開けたいなど
resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
