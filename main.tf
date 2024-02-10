provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-067983a1f071c98a2"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  # 元のインスタンスをterminateして実行したいため
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}
