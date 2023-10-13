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
 provisioner "local-exec" {
    command = "chmod 400 ./myKey.pem"
}
}
  resource "aws_instance" "web_instance" {
  ami             = var.ami_id
  instance_type   = var.inst_type
  count           = var.inst_count
  subnet_id       = aws_subnet.mysubnet.id
  key_name        = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.mysecurity.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }

  tags = {
    Name = "web"  # Assign the "web" tag to web instances
  }
}

resource "aws_instance" "app_instance" {
  ami             = var.ami_id
  instance_type   = var.inst_type
  count           = var.inst_count
  subnet_id       = aws_subnet.mysubnet.id
  key_name        = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.mysecurity.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }

  tags = {
    Name = "app"  # Assign the "app" tag to app instances
  }
}

resource "aws_instance" "db_instance" {
  ami             = var.ami_id
  instance_type   = var.inst_type
  count           = var.inst_count
  subnet_id       = aws_subnet.mysubnet.id
  key_name        = aws_key_pair.kp.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.mysecurity.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }

  tags = {
    Name = "db"  # Assign the "db" tag to database instances
  }
}
