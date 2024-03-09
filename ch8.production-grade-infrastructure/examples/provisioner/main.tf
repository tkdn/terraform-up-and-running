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
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-019d9da0f68cbf7c0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo \"hello, world  from $(uname -smp)\""
  }
}
