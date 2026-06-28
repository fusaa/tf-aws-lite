variable "region" {
  description = "AWS region for the state bucket."
  type        = string
  default     = "eu-west-2"
}

variable "state_bucket_name" {
  description = "Globally-unique name for the S3 state bucket."
  type        = string
}

variable "tags" {
  description = "Tags applied to the bootstrap resources."
  type        = map(string)
  default = {
    ManagedBy = "terraform"
    Purpose   = "remote-state-backend"
  }
}
