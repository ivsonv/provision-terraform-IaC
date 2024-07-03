terraform {
  required_version = ">=0.13.1"
  required_providers {
    aws = ">=3.54.1"
    local = ">=2.5.1"
  }
  backend "s3" {
    bucket = var.bucket_tfstate
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

module "vpc-pro-m3" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  prefix = var.prefix
}

module "eks" {
    source = "./modules/eks"
    
    subnet_ids = module.vpc-pro-m3.subnet_ids
    vpc_id = module.vpc-pro-m3.vpc_id

    cluster_name = var.cluster_name

    retention_days = var.retention_days
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
    prefix = var.prefix
}