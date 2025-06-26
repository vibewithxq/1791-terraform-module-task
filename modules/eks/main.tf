################################################### PHASE TWO: EKS MODULE ##########################################################

# This Creates an EKS Cluster With a Cluster Access Role
resource "aws_eks_cluster" "this" {
  name = var.eks_cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = [
      var.private_app_subnet_az1_id, #Refrence our subnets from the vpc Module
      var.private_app_subnet_az2_id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}
#This Creates the Cluster role and attaches the AWS Managed AmazonEKSClusterPolicy
resource "aws_iam_role" "cluster_role" {
  name = "cluster-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}


#This Creates a Node Group for the Cluster with max 
resource "aws_eks_node_group" "cluster_node_group" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cluster_AmazonEC2ContainerRegistryReadOnly,
  ]
}


#This Creates the Node Group Roles
resource "aws_iam_role" "node_group_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}