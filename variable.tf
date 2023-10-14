variable "ami_id" {
  type    = string
  default = "ami-080c09858e04800a1"
}

variable "inst_type" {
  type    = string
  default = "t2.micro"
}

variable "inst_count" {
  default = 1
}

variable "disk_size" {
  default = 8
}
