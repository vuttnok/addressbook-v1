terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}   
provider "aws" {
}


module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  env = var.env
}
