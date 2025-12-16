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

# CHANGE THIS: Pre-created connection ARN (See "Pre-requisites" section below)
variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar connection to GitHub"
  type        = string
  default = "arn:aws:codeconnections:us-east-1:269196137888:connection/4ffc60ef-8acd-4b09-836e-be6e15f02cff"
}
