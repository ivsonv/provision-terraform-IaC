resource "aws_vpc" "vpc-pro-m3" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.prefix}-vpc-pro-m3"
    }
}

## STEP 2
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

## STEP 3
resource "aws_internet_gateway" "igw-pro-m3" {
  vpc_id = aws_vpc.vpc-pro-m3.id
  tags = {
      Name = "${var.prefix}-igw-pro-m3"
  }
}

## STEP 4
resource "aws_route_table" "rtb-pro-m3" {
  vpc_id = aws_vpc.vpc-pro-m3.id
  route {
      cidr_block = "0.0.0.0/0" // all access
      gateway_id = aws_internet_gateway.igw-pro-m3.id
  }
  tags = {
      Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "rtb-association" {
  route_table_id = aws_route_table.rtb-pro-m3.id
  subnet_id = aws_subnet.subnets.*.id[count.index]
  count = 2
}