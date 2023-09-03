variable ami_id {
  type = string
  default = "ami_default"
}

variable inst_type {
  type = string
  default = "t2.micro"
}

variable sub_id {
  type = string
  default = "sub_xxxx"
}

variable web_count_num {
  type = string
  default = 1
 }

variable web_inst_tag {
  type = string
  default = "demo_inst"
 }

 variable app_count_num {
   type = string
   default = 1
  }

 variable app_inst_tag {
   type = string
   default = "demo_inst"
  }
