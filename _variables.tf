variable "proxy_name" {
  description = "Proxy name"
  type        = string
}

variable "engine_family" {
  description = "Proxy Engine Family"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the RDS Proxy"
  type        = list(string)
}

variable "cluster_identifier" {
  description = "Cluster identifier for the Aurora cluster"
  type        = string
}

variable "db_port" {
  description = "Database port number"
  type        = number
}

variable "username" {
  description = "Master username for database authentication"
  type        = string
}

variable "db_name" {
  description = "Name of the default database"
  type        = string
}

variable "rds_apps_sg_id" {
  description = "Security group ID for RDS applications"
  type        = string
}


