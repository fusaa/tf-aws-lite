# VPC Module

A deliberately minimal AWS VPC module, built to demonstrate module design and
core AWS networking — VPC, public/private subnets across availability zones,
internet gateway, optional NAT gateways, and route tables.

> For production estates the community `terraform-aws-modules/vpc/aws` module is
> the sensible default. This is a from-scratch implementation to show the
> internals rather than to replace it.

## Usage

```hcl
module "vpc" {
  source = "github.com/fusaa/tf-aws-lite//modules/vpc?ref=v1.0.0"

  name               = "platform-dev"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["eu-west-2a", "eu-west-2b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # set false for one NAT per AZ in production

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
```

## Design notes

- **Symmetric layout assumption.** Subnets are index-aligned with AZs: the Nth
  public and Nth private subnet share an AZ, and the per-AZ NAT routing relies on
  this. The common one-subnet-per-AZ layout satisfies it.
- **`count` over `for_each`.** Subnets use `count` for readability, matching the
  widely used community module. The trade-off is that removing a subnet from the
  middle of a list shifts later indices; keying by `for_each` would avoid this.
- **Cost control.** `single_nat_gateway` collapses to one NAT (cheaper, single
  point of failure) for dev; leave it off in production for per-AZ resilience.
