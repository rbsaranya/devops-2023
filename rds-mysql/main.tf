provider "aws" {
  region = "us-east-1" # Update this to your desired region
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "RDS MySQL security group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update this to restrict access
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-mysql-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-23456789"] # Update with your subnet IDs
}

resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
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

