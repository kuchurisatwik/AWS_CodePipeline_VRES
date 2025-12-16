resource "aws_codebuild_project" "backend_build" {
  name          = "${var.project_name}-backend-build"
  service_role  = var.codebuild_role_arn # Reusing existing Infra role or create new one if preferred

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0" # Ubuntu Standard
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "backend/buildspec.yml" # Looks in your repo backend folder
  }
}