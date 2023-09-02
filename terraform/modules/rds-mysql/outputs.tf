output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.rds_mysql.endpoint
}
