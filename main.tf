# =========================================================================
# 1. FRONTEND INFRASTRUCTURE
# =========================================================================

module "infra" {
  source       = "./modules/infrastructure"
  project_name = var.project_name
}

# =========================================================================
# 2. FRONTEND CI/CD PIPELINE
# =========================================================================

module "cicd" {
  source = "./modules/cicd"

  # 1. Global Project Vars
  project_name            = var.project_name
  aws_region              = var.aws_region
  
  # 2. GitHub Config
  github_repo_owner       = var.github_repo_owner
  github_repo_name        = var.github_repo_name
  github_branch           = var.github_branch
  codestar_connection_arn = var.codestar_connection_arn

  # 3. Inputs from Infrastructure Module
  website_bucket_name        = module.infra.website_bucket_name
  artifact_bucket_name       = module.infra.artifact_bucket_name
  cloudfront_distribution_id = module.infra.cloudfront_distribution_id
  codebuild_role_arn         = module.infra.codebuild_role_arn
  codepipeline_role_arn      = module.infra.codepipeline_role_arn
}

# =========================================================================
# 3. BACKEND INFRASTRUCTURE
#    (EC2 Instance, Security Groups, IAM Instance Profile)
# =========================================================================
module "backend_infra" {
  source        = "./modules/backend_infra"
  project_name  = var.project_name
  aws_region    = var.aws_region
}

# =========================================================================
# 4. BACKEND CI/CD PIPELINE
#    (CodePipeline -> CodeBuild -> CodeDeploy -> EC2)
# =========================================================================
module "backend_cicd" {
  source = "./modules/backend_cicd"

  # 1. Global Project Vars
  project_name            = var.project_name
  aws_region              = var.aws_region

  # 2. GitHub Config
  github_repo_owner       = var.github_repo_owner
  github_repo_name        = var.github_repo_name
  github_branch           = var.github_branch
  codestar_connection_arn = var.codestar_connection_arn

  # 3. Re-using Resources from Frontend Infra
  # (We use the same Artifact Bucket and IAM Roles to keep things simple)
  artifact_bucket_name  = module.infra.artifact_bucket_name
  codebuild_role_arn    = module.infra.codebuild_role_arn
  codepipeline_role_arn = module.infra.codepipeline_role_arn
}