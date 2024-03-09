variable "alb_name" {
  description = "ALB の名前"
  type        = string
}

variable "subnet_ids" {
  description = "subnet IDs to deploy to"
  type        = list(string)
}
