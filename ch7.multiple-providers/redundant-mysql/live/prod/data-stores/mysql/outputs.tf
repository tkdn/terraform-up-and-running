output "primary_db_address" {
  value = module.mysql_primary.address
}

output "primary_port" {
  value = module.mysql_primary.port
}

output "primary_arn" {
  value = module.mysql_primary.arn
}

output "replica_db_address" {
  value = module.mysql_replica.address
}

output "replica_port" {
  value = module.mysql_replica.port
}

output "replica_arn" {
  value = module.mysql_replica.arn
}
