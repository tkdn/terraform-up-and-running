provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_user" "exmapl" {
  count = 3
  name  = "neo.${count.index}"
}
