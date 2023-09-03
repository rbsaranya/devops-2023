module "aws_web" {
  source           = "../modules/ec2/instance"
  ami_id	         = var.ami_id
  inst_type        = var.inst_type
  sub_id	         = var.sub_id
  count_num	       = var.web_count_num
  inst_tag    	   = var.web_inst_tag
}

module "aws_app" {
  source           = "../modules/ec2/instance"
  ami_id           = var.ami_id
  inst_type        = var.inst_type
  sub_id	         = var.sub_id
  count_num        = var.app_count_num
  inst_tag         = var.app_inst_tag
}
