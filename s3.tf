# 1. Pipeline Artifact Store
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.project_name}-pipeline-artifacts-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

# 2. Frontend Hosting Bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.project_name}-hosting-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

# Block public access (CloudFront will access via Policy)
resource "aws_s3_bucket_public_access_block" "website_bucket_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket Policy to allow CloudFront OAC access
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website_distribution.arn
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}