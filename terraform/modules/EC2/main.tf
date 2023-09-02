resource "aws_instance" "my_instance" {
  ami           = var.ami_id # Replace with a valid AMI ID
  instance_type = var.inst_type
  subnet_id     = aws_subnet.my_subnet.id

  tags = {
    Name = "terraEC2Instance"
  }
}
