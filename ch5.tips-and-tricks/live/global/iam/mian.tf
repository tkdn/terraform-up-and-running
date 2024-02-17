provider "aws" {
  region = "ap-northeast-1"
}


module "users" {
  source = "../../../modules/landing-zone"

  for_each  = toset(var.user_names)
  user_name = each.value
}

resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe",
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name   = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "give_neo_cloudwatch_full_access" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0

  user       = var.user_names[0]
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_user_policy_attachment" "give_neo_cloudwatch_read_only" {
  count = var.give_neo_cloudwatch_full_access ? 0 : 1

  user       = var.user_names[0]
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}


variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morphes"]
}

output "user_arns" {
  value = values(module.users)[*].user_arn
}

variable "give_neo_cloudwatch_full_access" {
  type = bool
}

output "neo_cloudwatch_policy_arn" {
  value = (one(concat(
    aws_iam_user_policy_attachment.give_neo_cloudwatch_full_access[*].policy_arn,
    aws_iam_user_policy_attachment.give_neo_cloudwatch_read_only[*].policy_arn
  )))
}
