resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
}

output "rds_endpoint" {
  value = aws_db_instance.rds_mysql.endpoint
}
