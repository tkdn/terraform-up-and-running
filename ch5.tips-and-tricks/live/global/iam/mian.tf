provider "aws" {
  region = "ap-northeast-1"
}


resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}

output "all_users" {
  value = aws_iam_user.example
}

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}
