provider "aws" {
  region = "ap-northeast-1"
}


module "users" {
  source = "../../../modules/landing-zone"

  for_each  = toset(var.user_names)
  user_name = each.value
}

variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}

output "user_arns" {
  value = values(module.users)[*].user_arn
}
