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

# CHANGE THIS: Your specific GitHub details
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
}



variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}
