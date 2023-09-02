resource "aws_eip" "nat1" {
depends_on = [aws_internet_gateway.main]
}
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/18"
  tags = {
    Name = "main"
  }

resource "aws_internet_gateway" "main" {
vpc_id = aws_vpc.main.id
tags = {
name = "main"
}
}
resource "aws_subnet" "public_1"{
vpc_id = aws_vpc.main.id
cidr_block= "192.168.0.0/18"
availability_zone = "us-east-1"
map_public_ip_on_lunch = true
tags = {
name = "main"
}
}
resource "aws_nat_gateway" "gw1" {
allocation_id = aws_eip.nat1.id
subnet_id = Aws_subnet.public_1.id
tags = {
name = "NAT 1"
}
}
