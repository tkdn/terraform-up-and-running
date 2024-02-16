provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}

output "all_arns" {
  value = aws_iam_user.example[*].arn
}

output "first_user_arn" {
  value = aws_iam_user.example[0].arn
}
