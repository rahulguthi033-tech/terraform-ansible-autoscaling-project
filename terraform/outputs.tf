output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnets" {
  value = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id
  ]
}

output "private_subnets" {
  value = [
    aws_subnet.private_subnet_az1.id,
    aws_subnet.private_subnet_az2.id
  ]
}

output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}
