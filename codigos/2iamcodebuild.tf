
resource "aws_iam_role" "assume_codebuild_role" {
  name = "codebuild_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "codebuild.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF

}
data "aws_iam_policy_document" "cicd_build_policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*","iam:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "cicd_build_policy" {
    name = "cicd_build_policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.cicd_build_policies.json
}

resource "aws_iam_role_policy_attachment" "cicd_codebuild_attachment1" {
    policy_arn  = aws_iam_policy.cicd_build_policy.arn
    role        = aws_iam_role.assume_codebuild_role.id
}

resource "aws_iam_role_policy_attachment" "cicd_codebuild_attachment2" {
    policy_arn  = "arn:aws:iam::aws:policy/PowerUserAccess"
    role        = aws_iam_role.assume_codebuild_role.id
}
