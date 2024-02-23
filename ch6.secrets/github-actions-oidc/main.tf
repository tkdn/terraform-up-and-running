provider "aws" {
  region = "ap-northeast-1"
}

# GitHub を信頼するという IAM OIDC ID プロバイダを作成
resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.acitons.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.github.certificates[0].sha1_fingerprint
  ]
}

# GitHub OIDC サムプリントを取得
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# IAMロール
resource "aws_iam_role" "instance" {
  name_prefix        = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# 特定のリポジトリでIAMロールが引き受けられるようにする
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
      type        = "Federated"
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        for a in var.allowed_repos_branches :
        "repo:${a["org"]}/${a["repo"]}:ref:refs/heads/${a["branch"]}"
      ]
    }
  }
}

# EC2 Admin権限を与えるポリシーをIAMロールにアタッチ
resource "aws_iam_role_policy" "example" {
  role   = aws_iam_role.instance.id
  policy = data.aws_iam_policy_document.ec2_admin_premissions.json
}

# EC2 Admin権限ポリシー
data "aws_iam_policy_document" "ec2_admin_premissions" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}
