variable "cluster_name" {
  description = "The name to use for all the cluster resorces"
  type        = string
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
  default     = "ami-067983a1f071c98a2"
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

variable "enable_autoscaling" {
  type = bool
}

variable "custom_tags" {
  type    = map(string)
  default = {}
}

variable "server_port" {
  description = "The port the server will use for HTTP requests."
  type        = number
  default     = 8080
}

variable "server_text" {
  description = "The text the web server should return"
  type        = string
  default     = "Hello, World"
}

variable "subnet_ids" {
  description = "Subnet IDs to deploy to"
  type        = list(string)
}

variable "target_group_arns" {
  description = "ARNs of ALB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "health check to perform. Must be one of: EC2, ELB"
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "User Data script to run in instance at boot"
  type        = string
  default     = null
}
