variable "server_port" {
  description = "The port the server will use for HTTP requests."
  type        = number
  default     = 8080
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  default     = null
}

variable "db_remote_state_key" {
  description = "The path for database's remote state in S3"
  type        = string
  default     = null
}

variable "environment" {
  description = "environment, deployed to; e.g. production, stating"
  type        = string
}


/**
 * variables for module alb
 */
variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
}

variable "instance_type" {
  type = string
}

variable "server_text" {
  description = "The text the web server should return"
  type        = string
  default     = "Hello, World"
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "enable_autoscaling" {
  type = bool
}

variable "custom_tags" {
  type    = map(string)
  default = {}
}

/**
 * 新しく追加する変数
*/

variable "vpc_id" {
  type    = string
  default = null
}

variable "subnet_ids" {
  type    = list(string)
  default = null
}

variable "mysql_config" {
  type = object({
    address = string
    port    = number
  })
  default = null
}
