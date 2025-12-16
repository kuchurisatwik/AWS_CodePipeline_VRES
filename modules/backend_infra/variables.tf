variable "project_name" {}
variable "aws_region" {}
variable "key_pair_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access"
  type        = string
  default = "test1"
}