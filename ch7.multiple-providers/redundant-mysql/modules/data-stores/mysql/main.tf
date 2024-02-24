resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true

  # バックアップを有効化
  backup_retention_period = var.backup_retension_period
  # 指定されればこのDBはレプリカ
  replicate_source_db = var.replica_sourece_db

  # レプリカが設定されなければ有効にするパラメータを設定
  engine   = var.replica_sourece_db == null ? "mysql" : null
  db_name  = var.replica_sourece_db == null ? var.db_name : null
  username = var.replica_sourece_db == null ? var.db_username : null
  password = var.replica_sourece_db == null ? var.db_password : null
}
