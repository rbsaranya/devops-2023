resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_routetable" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.my_routetable.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id = aws_internet_gateway.my_igw.id
  }

resource "aws_route_table_association" "ma" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_routetable.id
}
