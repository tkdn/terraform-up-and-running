variable "allowed_repos_branches" {
  type = list(object({
    org    = string
    repo   = string
    branch = string
  }))
  default = [{
    org    = "tkdn"
    repo   = "terraform-up-and-running"
    branch = "ch6-manage-secrets"
  }]
}

variable "name" {
  type    = string
  default = "github-actions-oidc-example"
}
