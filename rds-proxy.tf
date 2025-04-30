resource "aws_db_proxy" "proxy" {
  name                   = var.proxy_name
  debug_logging          = false
  engine_family          = var.engine_family
  idle_client_timeout    = 1800
  require_tls            = false
  role_arn               = aws_iam_role.rds_proxy_role.arn
  vpc_security_group_ids = [var.rds_apps_sg_id]
  vpc_subnet_ids         = var.db_subnet_ids

  auth {
    auth_scheme               = "SECRETS"
    iam_auth                  = "DISABLED"
    secret_arn                = aws_secretsmanager_secret.proxy_rds_credentials.arn
    client_password_auth_type = var.client_password_auth_type
  }

}

resource "aws_db_proxy_target" "proxy_target" {
  db_proxy_name         = aws_db_proxy.proxy.name
  target_group_name     = "default"
  db_cluster_identifier = var.cluster_identifier
}

resource "aws_security_group_rule" "rds_apps_inbound_proxy" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = one(aws_db_proxy.proxy.vpc_security_group_ids)
  security_group_id        = var.rds_apps_sg_id
  description              = "RDS Proxy access"
}

resource "aws_db_proxy_endpoint" "proxy" {
  db_proxy_name          = aws_db_proxy.proxy.name
  db_proxy_endpoint_name = "${var.proxy_name}-read"
  vpc_subnet_ids         = var.db_subnet_ids
  target_role            = "READ_ONLY"
}
