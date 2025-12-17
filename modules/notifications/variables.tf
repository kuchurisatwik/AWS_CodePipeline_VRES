variable "project_name" {}
variable "alert_email" {
  description = "The email address to receive notifications"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar connection to GitHub"
  type        = string
  default = "arn:aws:codeconnections:us-east-1:269196137888:connection/4ffc60ef-8acd-4b09-836e-be6e15f02cff"
}