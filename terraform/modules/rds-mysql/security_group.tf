
resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "RDS MySQL security group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-mysql-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-23456789"]
}
