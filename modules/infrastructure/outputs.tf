# Export the Hosting Bucket Name so CodePipeline knows where to put the website
output "website_bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

# Export the Artifact Bucket Name for CodePipeline to store ZIPs
output "artifact_bucket_name" {
  value = aws_s3_bucket.codepipeline_bucket.bucket
}

# Export the Distribution ID for cache invalidation
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.website_distribution.id
}

# Export Roles (if needed by pipeline, though usually roles are strictly internal or passed carefully)
output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}