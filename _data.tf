data "aws_region" "current" {}

data "aws_rds_cluster" "cluster_endpoint" {
  cluster_identifier = var.cluster_identifier
}

data "aws_iam_policy_document" "rds_proxy_secret_access" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]
    resources = [aws_secretsmanager_secret.proxy_rds_credentials.arn]
  }
}

data "aws_iam_policy_document" "rds_proxy_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}