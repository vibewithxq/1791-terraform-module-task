variable "eks_cluster_name" {
  type = string
  description = "this is the name of the eks Cluster"
}

variable "eks_version" {
  type = string
  description = "this is the EKS Cluster version"
}

variable "node_group_name" {
  type = string
  description = "this is the Node group name for the cluster"
  
}

variable "node_group_desired_size" {
  type = string
  description = "the amount of desired nodes in the node group"
  default = "1"
}


variable "node_group_max_size" {
  type = string
  description = "the maximum amount of nodes allowed in the cluster"
  default = "2"
}


variable "node_group_min_size" {
  type = string
  description = "the minimum amount of nodes allowed in the cluster"
  default = "1"
}

variable "private_app_subnet_az1_id" {
  type = string
}

variable "private_app_subnet_az2_id" {
  type = string
}
