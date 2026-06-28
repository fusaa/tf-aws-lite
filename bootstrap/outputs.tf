output "state_bucket_name" {
  description = "Name of the S3 state bucket"
  value       = aws_s3_bucket.state.id
}

output "state_bucket_region" {
  description = "The region of the S3 state bucket"
  value       = var.region
}
