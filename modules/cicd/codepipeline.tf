resource "aws_codepipeline" "frontend_pipeline" {
  name     = "${var.project_name}-backend-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifact_bucket_name
    type     = "S3"
  }

  # STAGE 1: Source
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = "${var.github_repo_owner}/${var.github_repo_name}"
        BranchName       = "main"
      }
    }
  }

  # STAGE 2: Build
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.frontend_build.name
      }
    }
  }

  # STAGE 3: Deploy (S3 Upload + Invalidation)
  stage {
    name = "Deploy"

    # Action 1: Upload files to S3 Hosting Bucket
    action {
      name            = "S3_Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        BucketName = var.website_bucket_name
        Extract    = "true" # Unzips the artifact before upload
      }
      run_order = 1
    }

    # Action 2: Invalidate CloudFront
    action {
      name             = "Invalidate_Cache"
      category         = "Build" # Using CodeBuild for the invalidation command
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"] # Input required but ignored by the script
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.invalidate_cache.name
      }
      run_order = 2
    }
  }
}