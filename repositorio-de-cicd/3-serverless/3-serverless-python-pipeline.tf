
resource "aws_codebuild_project" "tf-plan-serverless-python" {
  name         = "cicd-build-python-${var.name_serverless_python}"
  description  = "pipeline for serverless"
  service_role = var.codebuild_role
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }
  source {
    type      = "CODEPIPELINE" #BITBUCKET
    buildspec = file("3-serverless/buildspec/buildspecpython.yml")
  }
}

resource "aws_codepipeline" "serverless-pipeline-python" {
  name     = "cicd-${var.name_serverless_python}"
  role_arn = var.codepipeline_role

  artifact_store {
    type     = "S3"
    location = var.s3_terraform_pipeline
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["tf-code"]
      configuration = {
        FullRepositoryId     = "culturadevops/serverless_python"
        BranchName           = "master"
        ConnectionArn        = var.codestar_connector_credentials
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  stage {
    name = "Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["tf-code"]
      configuration = {
        ProjectName = "cicd-build-python-${var.name_serverless_python}"
      }
    }
  }
}
