provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_user" "exmapl" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}
