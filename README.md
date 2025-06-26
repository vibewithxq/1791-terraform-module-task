# 1791-terraform-module-task

AWS Infrastructure Terraform Configuration
This repository contains Terraform configurations to deploy a foundational AWS infrastructure, including networking, an Amazon Elastic Kubernetes Service (EKS) cluster, and an Amazon DocumentDB cluster. This setup is designed to provide a secure and scalable environment for deploying containerized applications with a NoSQL database backend.
Terraform state manageent can be handled using an S3 backend with Terraform native statelocking


***Table of Contents***
Features

Architecture

Prerequisites

Usage

Configuration Variables

Outputs

*****Features****
This Terraform configuration sets up the following AWS resources:

******8Phase One: Networking Resources******
Virtual Private Cloud (VPC): A dedicated, isolated network for your AWS resources.

Internet Gateway (IGW): Enables communication between your VPC and the internet.

Availability Zones (AZs): Utilizes multiple availability zones for high availability.

Public Subnets (2): Subnets for resources that need direct internet access (e.g., Load Balancers, Bastion Hosts).

Private Application Subnets (2): Subnets for your application components (e.g., EKS worker nodes) that do not require direct internet access.

Private Data Subnets (2): Subnets for your database instances (e.g., DocumentDB) for enhanced security.

Route Tables: Configured for both public and private routes, with public subnets routing through the Internet Gateway.

Route Table Associations: Links subnets to their respective route tables.

*****Phase Two: EKS Module******
EKS Cluster: A fully managed Kubernetes control plane.

EKS Cluster IAM Role: An IAM role with necessary permissions for the EKS control plane to manage AWS resources.

EKS Node Group: A group of EC2 instances that act as worker nodes for your EKS cluster, deployed into private application subnets.

EKS Node Group IAM Role: An IAM role for the worker nodes with policies required for EKS worker functionality, CNI, and ECR access.

******Phase Three: Database******
Amazon DocumentDB Cluster: A managed NoSQL database service compatible with MongoDB, deployed into private data subnets.

DocumentDB Subnet Group: A collection of subnets (from your private data subnets) that DocumentDB instances can be launched into.

*****Architecture***
The architecture deploys resources across two Availability Zones for high availability.

A custom VPC is created to house all resources.

Public subnets are configured with routes to an Internet Gateway for internet access.

Private application subnets host the EKS cluster's worker nodes, ensuring they are not directly exposed to the internet.

Private data subnets host the DocumentDB cluster, providing an additional layer of isolation and security for the database.

IAM roles are meticulously configured to grant the EKS cluster and its node groups the least privilege necessary to operate.


********Prerequisites*************
Before deploying this infrastructure, ensure you have the following:

Terraform: Install Terraform (v1.0.0 or higher recommended).

AWS CLI: Install AWS CLI and configure your AWS credentials.

AWS Account: An active AWS account with sufficient permissions to create the necessary resources.


Usage
Follow these steps to deploy your AWS infrastructure using this Terraform configuration:

Clone the Repository (if applicable):

git clone <your-repo-url>
cd <your-repo-directory>

Initialize Terraform: Navigate to the root directory of this configuration (where init.tf is located) and initialize Terraform. This command downloads the necessary providers and modules.

terraform init

Review the Plan: Generate an execution plan to see what actions Terraform will perform. This is a crucial step to verify that the planned changes align with your expectations.

terraform plan --var-file=terraform.tfvars

Apply the Configuration: Apply the planned changes to provision the resources in your AWS account. You will be prompted to confirm the action by typing yes.

terraform apply --var-file=terraform.tfvars

Destroy Resources (Optional): If you need to tear down the entire infrastructure, you can use the destroy command. Be extremely cautious with this command as it will remove all provisioned resources.

terraform destroy

Variables
The main.tf file uses several input variables to parameterize the deployment. These variables can be defined in a terraform.tfvars file, passed via the command line (-var), or set as environment variables.

Here are the variables used in the provided main.tf snippet:

region:

Description: The AWS region where the resources will be deployed.

Example: us-east-1

aws_vpc_cidr_block:

Description: The CIDR block for the main VPC.

Example: 10.0.0.0/16

private_app_subnet_az1_cidr:

Description: CIDR block for the private application subnet in Availability Zone 1.

Example: 10.0.1.0/24

private_app_subnet_az2_cidr:

Description: CIDR block for the private application subnet in Availability Zone 2.

Example: 10.0.2.0/24

private_data_subnet_az1_cidr:

Description: CIDR block for the private data subnet in Availability Zone 1.

Example: 10.0.3.0/24

private_data_subnet_az2_cidr:

Description: CIDR block for the private data subnet in Availability Zone 2.

Example: 10.0.4.0/24

public_subnet_az1_cidr:

Description: CIDR block for the public subnet in Availability Zone 1.

Example: 10.0.5.0/24

public_subnet_az2_cidr:

Description: CIDR block for the public subnet in Availability Zone 2.

Example: 10.0.6.0/24

project_name:

Description: A name used to tag resources, helping with identification and cost allocation.

Example: my-application

eks_cluster_name:

Description: The desired name for the EKS cluster.

Example: my-eks-cluster

eks_version:

Description: The Kubernetes version for the EKS cluster.

Example: 1.28

node_group_name:

Description: The name for the EKS Node Group.

Example: my-node-group

docdb_subnet_group_name:

Description: The name for the DocumentDB Subnet Group.

Example: my-docdb-subnet-group

docdb_cluster_idendifier:

Description: The identifier for the DocumentDB cluster.

Example: my-docdb-cluster