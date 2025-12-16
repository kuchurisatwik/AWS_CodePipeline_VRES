variable "project_name" {
  description = "Base name for resources"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar connection to GitHub"
  type        = string
}