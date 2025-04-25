# terraform-aws-template

[![Lint Status](https://github.com/DNXLabs/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-template)](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE)

## Module Example
```
module "rds_proxy" {
  source = "git::https://github.com/DNXLabs/terraform-aws-rds-proxy.git?ref=1.0"

  count = local.workspace.create_proxy ? 1 : 0

  proxy_name              = try(local.workspace["proxy_name"], "")
  engine_family           = try(local.workspace["engine_family"], "") 
  db_subnet_ids           = try(local.workspace["db_subnet_ids"], [])
  cluster_identifier      = try(local.workspace["bb_2_cluster_identifier"], "")
  db_port                 = try(local.workspace["bb_2_db_port"], "")
  username                = try(local.workspace["bb_2_username"], "")
  db_name                 = try(local.workspace["bb_2_db_name"], "")
  rds_apps_sg_id          = try(local.workspace["rds_apps_sg_id"], "")
}
```

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |

## Providers

No provider.

## Inputs

No input.

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.