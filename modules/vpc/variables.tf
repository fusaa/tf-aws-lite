variable "name" {
  description = "Name prefix applied to the VPC and all resources created by this module"
  type        = string
}

variable "cidr_block" {
  description = "IPv4 CIDR block for the VPC (e.g. 10.0.0.0/16)"
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid IPv4 CIDR, for example 10.0.0.0/16"
  }
}

variable "availability_zones" {
  description = "AZs to distribute subnets across."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "Provide at least one availability zone"
  }
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets, index-aligned with availability_zones"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets, index-aligned with availability_zones"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Create NAT gateway(s) so private subnets get outbound internet access"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Share one NAT gateway across all AZs. Cheaper, but a single point of failure — non-production only"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to all resources created by this module"
  type        = map(string)
  default     = {}
}
