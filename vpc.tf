resource "aws_vpc" "vpc-pro-m3" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "tag-vpc-pro-m3"
    }
}