#creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.8.0.0/16"
}
