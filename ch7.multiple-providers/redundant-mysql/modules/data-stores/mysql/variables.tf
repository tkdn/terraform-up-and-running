variable "backup_retension_period" {
  description = "バックアップを保持する日数"
  type        = number
  default     = null
}

variable "replica_sourece_db" {
  description = "指定があれば、ARNにレプリカDBを作成する"
  type        = string
  default     = null
}

variable "db_name" {
  type    = string
  default = null
}

variable "db_username" {
  type    = string
  default = null
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = null
}
