provider "aws" {
  region = "ap-northeast-1"
}


module "users" {
  source = "../../../modules/landing-zone"

  count     = length(var.user_names)
  user_name = var.user_names[count.index]
}

variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}

output "users_arn" {
  value = module.users[*].user_arn
}
