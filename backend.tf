terraform {
  backend "s3" {
    bucket = "devops2023-terraformstate"
    key    = "dev/devops/terraform"
    region = "us-east-1"
  }
}
