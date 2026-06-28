terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "fusaa-tfstate-platform"
    key          = "examples/vpc-simple/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true # use_lockfile
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  #source = "github.com/fusaa/tf-aws-lite//modules/vpc?ref=v1.0.0"
  source = "../../modules/vpc"

  name               = "platform-dev"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["eu-west-2a", "eu-west-2b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # shared NAT

  tags = {
    Environment = "dev"
    Project     = "platform-foundations"
    ManagedBy   = "terraform"
  }
}
