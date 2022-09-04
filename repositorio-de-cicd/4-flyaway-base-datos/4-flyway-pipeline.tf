
resource "aws_codebuild_project" "tf-flyaway1" {
  name          = "cicd-build-${var.name_flyaway}"
  description   = "pipeline for microservicio1"
  service_role  = var.codebuild_role

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    #image                       = "flyway/flyway:8.5.10"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
        environment_variable {
        type = "SECRETS_MANAGER"
        name  = "BD_HOST"
        value = "${aws_secretsmanager_secret_version.rds_credentials.arn}:Host"
    }
            environment_variable {
        type = "SECRETS_MANAGER"
        name  = "BD_PORT"
        value = "${aws_secretsmanager_secret_version.rds_credentials.arn}:Port"
    }
        environment_variable {
              type = "SECRETS_MANAGER"
            name  = "BD_USER"
            value = "${aws_secretsmanager_secret_version.rds_credentials.arn}:Username"
        }
        environment_variable {
            type = "SECRETS_MANAGER"
            name  = "BD_PASS"
            value = "${aws_secretsmanager_secret_version.rds_credentials.arn}:Password"
        }
        environment_variable {
            type = "SECRETS_MANAGER"
            name = "DOCKERHUB_USER"
            value = "${var.dockerhub_credentials}:Username"
            }
            environment_variable {
            type = "SECRETS_MANAGER"
            name = "DOCKERHUB_PASS"
            value = "${var.dockerhub_credentials}:Password"
            }
 }
 source {
     type   = "CODEPIPELINE"#BITBUCKET
     buildspec = file("4-flyaway-base-datos/buildspec.yml" )
 }
}



resource "aws_codepipeline" "flyaway1_pipeline" {

    name = "cicd-${var.name_flyaway}"
    role_arn = var.codepipeline_role

    artifact_store {
        type="S3"
        location = var.s3_terraform_pipeline
    }

    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeStarSourceConnection"
            version = "1"
            output_artifacts = [
                    "SourceArtifact",
            ]
            configuration = {
                FullRepositoryId = "culturadevops/flyaway1.git"
                BranchName   = "master"
                ConnectionArn = var.codestar_connector_credentials
                OutputArtifactFormat = "CODE_ZIP"
            }
        }
    }

    stage {
        name ="carga"
        action{
            name = "Build"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = [
                "SourceArtifact",
            ]
     
            output_artifacts = [
                "BuildArtifact",
            ]
            configuration = {
                ProjectName = "cicd-build-${var.name_flyaway}"
            }
        }
    }
  

}