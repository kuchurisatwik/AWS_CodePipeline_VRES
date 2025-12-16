# 1. Get the CloudFront URL from the INFRA module
output "cloudfront_url" {
  description = "The URL of the deployed frontend"
  value       = "https://${module.infra.cloudfront_domain_name}"
}

# 2. Get the Pipeline URL from the CICD module
# Note: This will only show a value AFTER you run the cicd target.
output "pipeline_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${var.project_name}-pipeline/view"
}