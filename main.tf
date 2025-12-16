# 1. CALL THE INFRASTRUCTURE MODULE
module "infra" {
  source                  = "./modules/infrastructure"
  project_name            = var.project_name
  codestar_connection_arn = var.codestar_connection_arn
}

# 2. CALL THE CI/CD MODULE
module "cicd" {
  source = "./modules/cicd"

  # Pass Global Variable
  project_name            = var.project_name
  github_repo_owner       = var.github_repo_owner
  github_repo_name        = var.github_repo_name
  github_branch           = var.github_branch
  codestar_connection_arn = var.codestar_connection_arn

  # 🚀 PASS DATA FROM INFRA TO CI/CD
  website_bucket_name        = module.infra.website_bucket_name
  artifact_bucket_name       = module.infra.artifact_bucket_name
  cloudfront_distribution_id = module.infra.cloudfront_distribution_id
  codebuild_role_arn         = module.infra.codebuild_role_arn
  codepipeline_role_arn      = module.infra.codepipeline_role_arn
}