module "dev_s3" {
  source    = "../modules/s3"
  buck_name = "platyyo-s3-dev"
}

module "dev_rds" {
  source            = "../modules/rds-mysql"
  region            = "us-east-1"
  inst_type         = "db.t2.micro"
  allocated_storage = 20
}

