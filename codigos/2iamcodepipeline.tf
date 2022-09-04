
resource "aws_iam_role" "assume_codepipeline_role" {
  name = "codepipeline_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "codepipeline.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF

}

data "aws_iam_policy_document" "cicd_pipeline_policies" {
    statement{
        sid = ""
        actions = ["codestar-connections:UseConnection"]
        resources = ["*"]
        effect = "Allow"
    }
    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*", "codebuild:*","codecommit:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "cicd_pipeline_policy" {
    name = "cicd_pipeline_policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.cicd_pipeline_policies.json
}

resource "aws_iam_role_policy_attachment" "cicd_pipeline_attachment" {
    policy_arn = aws_iam_policy.cicd_pipeline_policy.arn
    role = aws_iam_role.assume_codepipeline_role.id
}

