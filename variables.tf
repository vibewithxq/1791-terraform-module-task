variable "region" {
  type = string
  description = "the default region"
}
variable "project_name" {
  type = string
  description = "the name of the project"
}

variable "aws_vpc_cidr_block" {
  type = string
  description = "the vpc cidr block"
}

variable "private_app_subnet_az1_cidr" {
  type = string
  description = "the private app subnet cidr block for az1"
}

variable "private_app_subnet_az2_cidr" {
  type = string
  description = "the private app subnet cidr block for az2"
}

variable "private_data_subnet_az1_cidr" {
  type = string
  description = "the private data subnet cidr for az1"
}

variable "private_data_subnet_az2_cidr" {
  type = string
  description = "the private data subnet cidr block for az2"
}

variable "public_subnet_az1_cidr" {
  type = string
  description = "the public subnet cidr block for az1"
}

variable "public_subnet_az2_cidr" {
  type = string
  description = "the public subnet cidr block for az2"
}

variable "eks_cluster_name" {
  type = string
  description = "the name of the eks Cluster"
}

variable "eks_version" {
  type = string
  description = "the eks version"
}

variable "node_group_name" {
  type = string
  description = "the node group name of the eks cluster"  
}

variable "docdb_subnet_group_name" {
  type = string
  description = "the name of the docdb subnet group"
}

variable "docdb_cluster_idendifier" {
  type = string
  description = "the cluster identifier for document db"
}