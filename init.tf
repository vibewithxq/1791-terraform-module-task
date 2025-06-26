module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr_block = var.aws_vpc_cidr_block
  private_app_subnet_az1_cidr =  var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
   public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  project_name = var.project_name
}



module "eks" {
  source = "./modules/eks"
  eks_cluster_name = var.eks_cluster_name
  eks_version = var.eks_version
  node_group_name = var.node_group_name
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
}


module "docdb" {
  source = "./modules/documentdb"
  docdb_subnet_group_name = var.docdb_subnet_group_name
  docdb_cluster_idendifier = var.docdb_cluster_idendifier
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}