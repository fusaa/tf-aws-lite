output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs - public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs - private subnets"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID - internet gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "IDs - gateways"
  value       = aws_nat_gateway.this[*].id
}

output "public_route_table_id" {
  description = "ID - public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs - private route tables"
  value       = aws_route_table.private[*].id
}
