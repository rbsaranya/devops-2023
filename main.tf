resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "MySubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}
resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_security_group" "mysecurity" {
  name        = "mysecurity"
  description = "Security group for ec2"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJ9BacBX/P61rhHaUDZLlMhTWKnj8M2KVruA49OMAX9qcWWhJgRrk9K864wg8+ykNQbWLn6w6nX/z0F6ilNqXzRKODwIyYE6zTIQb3UkZYPYqNarNEdNaadAErEWMPRAEZQCsQtiKT8qYizo2wNxrrqHTxPy3+4EHBPeX0cahXbMgcdL6r0EfPaexXPg6OPhRhsOH726iOZAS8OZnEVAqKrnrtO5fbIiV6RMECMgB2q4sed+8OmIIPyozDgcdlkEuUUlZimAtQVA9uWZ7EjNzcEqzDVxCPgjRbtT+A5bLBCkswnCmiYFD1x0887vI3xmkHOi8BDpZw2lZXNLDn6z1dxhOrGc1ZEeeLDvtp40cTwH66e4yGIK60+g1XkwoKdYNY+s/E8LTntLCF8AtL1d2KhXJBWFo08VuUA/BSEPmIIyP5Pu7bvlZBi0h3xwNeoN0LOZAMPsPqTHn3hBpC4XfjR1MzRsKecIPlp24oVLyAo8zRgPxlaQK0qM2sXizijOs= rbsaranya@gmail.com" # Replace this with your SSH public key
}

resource "aws_instance" "terraform" {
  ami             = var.ami_id
  instance_type   = var.inst_type
  count           = var.inst_count
  subnet_id       = aws_subnet.mysubnet.id
  key_name        = aws_key_pair.mykeypair.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.mysecurity.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }
  tags = {
    Name = "terraDEvInstance"
  }

}
