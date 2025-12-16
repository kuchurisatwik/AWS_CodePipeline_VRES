# 1. Project to Build Frontend (npm install & build)
resource "aws_codebuild_project" "frontend_build" {
  name          = "${var.project_name}-build"
  description   = "Builds the frontend application"
  service_role  = var.codebuild_role_arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "frontend/buildspec.yml" # Looks for this file in your repo
  }
}

# 2. Project to Invalidate Cache (AWS CLI command)
resource "aws_codebuild_project" "invalidate_cache" {
  name          = "${var.project_name}-invalidate"
  description   = "Invalidates CloudFront cache"
  service_role  = var.codebuild_role_arn
  build_timeout = "5"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = yamlencode({
      version = 0.2
      phases = {
        build = {
          commands = [
            "echo Invalidating CloudFront Distribution ${var.cloudfront_distribution_id}...",
            "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.website_distribution.id} --paths \"/*\""
          ]
        }
      }
    })
  }
}