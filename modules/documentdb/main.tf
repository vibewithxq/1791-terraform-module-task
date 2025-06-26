####################### PHASE THREE: DATABASE ##################################

# This creates a documentdb cluster
resource "aws_docdb_cluster" "mydocdbcluster" {
  cluster_identifier      = var.docdb_cluster_idendifier
  engine                  = "docdb"
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = true
  deletion_protection = true
  db_subnet_group_name = aws_db_subnet_group.docdb_subnet_group.name
}

# This creates the subnet group for the cluster
resource "aws_db_subnet_group" "docdb_subnet_group" {
  name       = var.docdb_subnet_group_name
  subnet_ids = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id]

  tags = {
    Name = var.docdb_subnet_group_name
  }
}