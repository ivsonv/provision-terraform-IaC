variable "vpc_id" {} // aws_vpc.vpc-pro-m3.id
variable "prefix" {}
variable "cluster_name" {}
variable "retention_days" {}
variable "subnet_ids" {} //aws_subnet.subnets[*].id

variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}