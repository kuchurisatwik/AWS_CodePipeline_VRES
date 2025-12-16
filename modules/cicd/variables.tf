# ==========================================
# 1. Global Project Variables (Passed from Root)
# ==========================================

variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "chatapp-frontend"
}

variable "github_repo_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "kuchurisatwik"
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
  default     = "chatapp"
}

variable "github_branch" {
  description = "Branch to trigger the pipeline"
  type        = string
  default     = "main"
}

# CHANGE THIS: Pre-created connection ARN (See "Pre-requisites" section below)
variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar connection to GitHub"
  type        = string
  default = "arn:aws:codeconnections:us-east-1:269196137888:connection/4ffc60ef-8acd-4b09-836e-be6e15f02cff"
}



# ==========================================
# 2. Infrastructure Inputs (Coming from 'infra' Module)
# ==========================================
# These variables do NOT have defaults because they MUST 
# be provided by the output of your infrastructure module.

variable "website_bucket_name" {
  description = "Name of the S3 bucket where the website is hosted"
  type        = string
  default = "chatapp-frontend-hosting-269196137888"
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket where pipeline artifacts are stored"
  type        = string
  default = "chatapp-frontend-pipeline-artifacts-269196137888"
}

variable "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution to invalidate"
  type        = string
  default = "E280CWAD4BUV31"
}

variable "codebuild_role_arn" {
  description = "ARN of the IAM role for CodeBuild"
  type        = string
  default = "arn:aws:iam::269196137888:role/chatapp-frontend-codebuild-role"
}


#ARn for invalidation build ??????think later

variable "codepipeline_role_arn" {
  description = "ARN of the IAM role for CodePipeline"
  type        = string
  default = "arn:aws:iam::269196137888:role/chatapp-frontend-codepipeline-role"
}









