resource "aws_instance" "demo-terraform" {
  ami           = var.ami_id
  instance_type = var.inst_type
  count         = var.inst_count

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }
}

