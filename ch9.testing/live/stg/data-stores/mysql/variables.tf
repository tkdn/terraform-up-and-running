variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "example_database_staging"
}
