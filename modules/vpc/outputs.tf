output "vpc_id" {
  value = aws_vpc.vpc-pro-m3.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}