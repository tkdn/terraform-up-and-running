variable "mysql_config" {
  type = object({
    address = string
    port    = number
  })
  default = {
    address = "mock-mysql-address"
    port    = 4403
  }
}

variable "environment" {
  default     = "The name of the environment we're deploying to"
  type        = string
  description = "example"
}
