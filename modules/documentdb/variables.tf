variable "docdb_cluster_idendifier" {
  type = string
  description = "the identifier for the cluster"
}

variable "master_username" {
  type = string
  description = "the docdb username"
  default = "admin"
}

variable "master_password" {
  type = string
  description = "the password for the cluster"
  default = "Changeme@1"
}

variable "backup_retention_period" {
  description = "the amount of days in which the cluster snapshots will be stored"
  default = "5"
}


variable "docdb_subnet_group_name" {
  type = string
}


variable "private_data_subnet_az1_id" {
  type = string
}

variable "private_data_subnet_az2_id" {
  type = string
}