resource "aws_iam_user" "example" {
  name = var.user_name
}

variable "user_name" {
  type = string
}

output "user_arn" {
  value = aws_iam_user.example.arn
}
