provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "ec2_from_github_actions" {
  ami           = "ami-067983a1f071c98a2"
  instance_type = "t2.micro"

  tags = {
    "Name" = "from-github-actions"
  }
}
