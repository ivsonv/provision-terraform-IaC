resource "aws_vpc" "vpc-pro-m3" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.prefix}-vpc-pro-m3"
    }
}

data "aws_availability_zones" "available" { }

resource "aws_subnet" "subnets" {
    availability_zone = data.aws_availability_zones.available.names[count.index]
    count = 2

    vpc_id     = aws_vpc.vpc-pro-m3.id # REF NAME WITH VPC NAME
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-${count.index}"
    }
}