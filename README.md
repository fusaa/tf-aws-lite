# tf-aws-lite

A small collection of hand-built, reusable Terraform modules for AWS — written
to demonstrate module design, AWS fundamentals, and the quality gates a real
platform team relies on (remote state, CI validation, linting, and IaC security
scanning).

![CI](https://github.com/fusaa/tf-aws-lite/actions/workflows/ci.yml/badge.svg)
![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.10-7B42BC?logo=terraform&logoColor=white)
![AWS Provider](https://img.shields.io/badge/AWS_Provider-~%3E6.0-FF9900?logo=amazonwebservices&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue)

> These modules are built from scratch to show how the internals work. For
> production estates the community modules (e.g. `terraform-aws-modules/vpc/aws`)
> are the sensible default; this repository is about demonstrating the craft, not
> replacing them.

## Repository layout

```text
.
├── .github/workflows/ci.yml   # fmt · validate · tflint · trivy
├── bootstrap/                 # one-time: creates the S3 remote-state backend
├── modules/
│   └── vpc/                   # VPC, subnets, IGW, optional NAT, route tables
├── examples/
│   └── vpc-simple/            # runnable example consuming the vpc module
├── .tflint.hcl
├── .pre-commit-config.yaml
└── README.md
```

## Modules

| Module | Description |
| ------ | ----------- |
| [`vpc`](modules/vpc) | VPC with public and private subnets across AZs, internet gateway, optional NAT gateways, and route tables. |

> More modules (`s3-bucket`, `eks`) are planned to grow the collection.

## Getting started

**1. Stand up the remote-state backend (once).** State is stored in S3 with
native S3 locking (`use_lockfile`), created by the bootstrap config, which runs
on local state because the backend it creates doesn't exist yet.

```bash
cd bootstrap
terraform init
terraform apply -var="state_bucket_name=fusaa-tfstate-<unique>"
```

**2. Consume a module.** Point any config at the bucket from step 1 and call the
module. See [`examples/vpc-simple`](examples/vpc-simple) for a complete, runnable
config.

```bash
cd examples/vpc-simple
terraform init
terraform plan
```

External consumers pin to a released tag:

```hcl
module "vpc" {
  source = "github.com/fusaa/tf-aws-lite//modules/vpc?ref=v1.0.0"
  # ...
}
```

## Quality gates

Every push and pull request runs static checks — no cloud credentials required:

| Check | Tool |
| ----- | ---- |
| Formatting | `terraform fmt -check` |
| Validity | `terraform validate` (per module and example) |
| Linting | `tflint` with the AWS ruleset |
| Security | `trivy` IaC scan |

The same checks run locally before each commit via `pre-commit`, along with
`terraform-docs` to keep each module's input/output tables current. GitHub
Actions are pinned to commit SHAs (not mutable tags) as a supply-chain
precaution.

## Requirements

- Terraform >= 1.10 (native S3 state locking)
- AWS provider ~> 6.0
- An AWS account and credentials for `plan`/`apply`
- For local development: `tflint`, `trivy`, `pre-commit`, `terraform-docs`

## Versioning

Modules follow semantic versioning via git tags. Consumers pin to a tag with
`?ref=vX.Y.Z` so an upgrade is always a deliberate choice.

## License

MIT — see [LICENSE](LICENSE).
