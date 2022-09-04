
resource "aws_codepipeline" "cicd_pipeline" {
  name     = "terraform-cicd"
  role_arn = aws_iam_role.assume_codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_artifacts.id
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["code"]
      configuration = {
        RepositoryName       = "repositorio-de-cicd"
        BranchName           = "master"
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
      input_artifacts = ["code"]
      configuration = {
        ProjectName = "cicd-plan"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["code"]
      configuration = {
        ProjectName = "cicd-apply"
      }
    }
  }

}































  #    stage {
  #        name = "Source"
  #        action{
  #            name = "Source"
  #            category = "Source"
  #            owner = "AWS"
  #            provider = "CodeStarSourceConnection"
  #            version = "1"
  #            output_artifacts = ["code"]
  #            configuration = {
  #                FullRepositoryId = "culturadevops/"
  #                BranchName   = "master"
  #                ConnectionArn =aws_codestarconnections_connection.example.arn
  #                OutputArtifactFormat = "CODE_ZIP"
  #            }
  #        }
  #    }
