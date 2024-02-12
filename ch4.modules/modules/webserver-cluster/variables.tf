variable "server_port" {
  description = "The port the server will use for HTTP requests."
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all the cluster resorces"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for database's remote state in S3"
  type        = string
}

variable "instance_type" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}
