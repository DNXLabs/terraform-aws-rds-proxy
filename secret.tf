resource "aws_secretsmanager_secret" "proxy_rds_credentials" {
  name        = "${var.proxy_name}-secret"
  description = "Credentials for RDS Proxy authentication"
}

resource "aws_iam_role_policy" "rds_proxy_secret_policy" {
  name   = "rds-proxy-secret-access"
  role   = aws_iam_role.rds_proxy_role.name
  policy = data.aws_iam_policy_document.rds_proxy_secret_access.json
}

resource "aws_secretsmanager_secret_version" "proxy_credentials" {
  secret_id = aws_secretsmanager_secret.proxy_rds_credentials.id
  secret_string = jsonencode({
    username            = var.username
    password            = "changeme"
    engine              = lower(var.engine_family)
    host                = data.aws_rds_cluster.cluster_endpoint.endpoint
    port                = var.db_port
    dbClusterIdentifier = var.cluster_identifier
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}