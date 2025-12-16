variable "project_name" {}
variable "aws_region" {}
variable "codestar_connection_arn" {}
variable "github_repo_owner" {}
variable "github_repo_name" {}
variable "github_branch" {}

# Inputs from Infra/Root
variable "artifact_bucket_name" {}
variable "codebuild_role_arn" {}
variable "codepipeline_role_arn" {}