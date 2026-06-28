output "vpc_id" {
  description = "ID - VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs - public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs - private subnets"
  value       = module.vpc.private_subnet_ids
}
