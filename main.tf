provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-067983a1f071c98a2"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
