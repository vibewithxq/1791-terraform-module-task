Terraform AWS Infrastructure
This repository contains a Terraform configuration to provision a robust and scalable infrastructure on AWS, including a Virtual Private Cloud (VPC), an Elastic Kubernetes Service (EKS) cluster, and an Amazon DocumentDB cluster.

Table of Contents
Introduction

Modules Used

VPC Module

EKS Module

DocumentDB Module

Prerequisites

Usage

Variables

Introduction
This Terraform setup automates the deployment of core AWS services. It's designed to provide a secure and isolated network environment (VPC), a managed Kubernetes service for container orchestration (EKS), and a NoSQL document database (DocumentDB) for your applications.

Modules Used
The configuration leverages local Terraform modules to logically separate and manage different infrastructure components:

VPC Module
source = "./modules/vpc"

This module is responsible for setting up the networking infrastructure. It provisions:

A new Virtual Private Cloud (VPC) with a specified CIDR block.

Public subnets across multiple Availability Zones (AZs) for public-facing resources.

Private application subnets across multiple AZs for application instances.

Private data subnets across multiple AZs for database instances, ensuring isolation.

Internet Gateway, NAT Gateways, and Route Tables to enable connectivity.

EKS Module
source = "./modules/eks"

This module deploys an Elastic Kubernetes Service (EKS) cluster. It configures:

An EKS control plane with a specified Kubernetes version.

An EKS Node Group, which consists of EC2 instances that serve as worker nodes for your Kubernetes cluster.

It utilizes the private application subnets created by the vpc module to ensure that EKS worker nodes are in a private network segment.

DocumentDB Module
source = "./modules/documentdb"

This module sets up an Amazon DocumentDB (with MongoDB compatibility) cluster. It includes:

A DocumentDB Subnet Group to associate the database instances with specific subnets.

A DocumentDB Cluster with a unique identifier.

It uses the private data subnets from the vpc module to ensure the DocumentDB instances are securely isolated within your VPC.

Prerequisites
Before you can run this Terraform configuration, ensure you have the following installed and configured:

AWS CLI: Configured with appropriate credentials and default region.

aws configure

Terraform: Version 0.13 or higher.

brew install terraform # macOS
# Or follow official Terraform installation guide

An AWS Account: With sufficient permissions to create VPCs, EKS clusters, and DocumentDB clusters.

Usage
Follow these steps to deploy your AWS infrastructure using this Terraform configuration:

Clone the Repository (if applicable):

git clone <your-repo-url>
cd <your-repo-directory>

Initialize Terraform: Navigate to the root directory of this configuration (where main.tf is located) and initialize Terraform. This command downloads the necessary providers and modules.

terraform init

Review the Plan: Generate an execution plan to see what actions Terraform will perform. This is a crucial step to verify that the planned changes align with your expectations.

terraform plan

Apply the Configuration: Apply the planned changes to provision the resources in your AWS account. You will be prompted to confirm the action by typing yes.

terraform apply

Destroy Resources (Optional): If you need to tear down the entire infrastructure, you can use the destroy command. Be extremely cautious with this command as it will remove all provisioned resources.

terraform destroy

Variables
The main.tf file uses several input variables to parameterize the deployment. These variables can be defined in a terraform.tfvars file, passed via the command line (-var), or set as environment variables.

Variable Name

Description

Example

region

The AWS region where the resources will be deployed.

us-east-1

aws_vpc_cidr_block

The CIDR block for the main VPC.

10.0.0.0/16

private_app_subnet_az1_cidr

CIDR block for the private application subnet in Availability Zone 1.

10.0.1.0/24

private_app_subnet_az2_cidr

CIDR block for the private application subnet in Availability Zone 2.

10.0.2.0/24

private_data_subnet_az1_cidr

CIDR block for the private data subnet in Availability Zone 1.

10.0.3.0/24

private_data_subnet_az2_cidr

CIDR block for the private data subnet in Availability Zone 2.

10.0.4.0/24

public_subnet_az1_cidr

CIDR block for the public subnet in Availability Zone 1.

10.0.5.0/24

public_subnet_az2_cidr

CIDR block for the public subnet in Availability Zone 2.

10.0.6.0/24

project_name

A name used to tag resources, helping with identification and cost allocation.

my-application

eks_cluster_name

The desired name for the EKS cluster.

my-eks-cluster

eks_version

The Kubernetes version for the EKS cluster.

1.28

node_group_name

The name for the EKS Node Group.

my-node-group

docdb_subnet_group_name

The name for the DocumentDB Subnet Group.

my-docdb-subnet-group

docdb_cluster_idendifier

The identifier for the DocumentDB cluster.

my-docdb-cluster

