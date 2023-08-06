#creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.8.0.0/16"
}

#Creating Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.8.0.0/24"
}

#Creating Internet Gatway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

#Creating route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

#Creating routing table entry
resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

#Adding Subnet Association
resource "aws_route_table_association" "my_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

#Creating Public key
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Creating keypair in the present working directory
resource "aws_key_pair" "kp" {
  key_name   = "myKey" 
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

#Creating Security Group
resource "aws_security_group" "my_security_group" {
  name        = "allow-ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#creating EC2 instance
resource "aws_instance" "my_instance" {
  ami                         = var.ami_id
  instance_type               = var.inst_type
  subnet_id                   = aws_subnet.my_subnet.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.kp.key_name
  security_groups             = [aws_security_group.my_security_group.id]

  tags = {
    Name = "terraformEC2"
  }
}

