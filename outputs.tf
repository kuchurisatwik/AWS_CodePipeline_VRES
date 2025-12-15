output "cloudfront_url" {
  description = "The URL of the deployed frontend"
  value       = "https://${aws_cloudfront_distribution.website_distribution.domain_name}"
}

output "pipeline_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.frontend_pipeline.name}/view"
}