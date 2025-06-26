# Terraform AWS Infrastructure

This repository contains a Terraform configuration to provision a robust and scalable infrastructure on AWS, including a Virtual Private Cloud (VPC), an Elastic Kubernetes Service (EKS) cluster, and an Amazon DocumentDB cluster. State Mangement can be handled locally or by an s3 backend with Native Locking

---

## Table of Contents

- [Introduction](#introduction)  
- [Modules Used](#modules-used)  
  - [VPC Module](#vpc-module)  
  - [EKS Module](#eks-module)  
  - [DocumentDB Module](#documentdb-module)  
- [Prerequisites](#prerequisites)  
- [Usage](#usage)  
- [Variables](#variables)

---

## Introduction

This Terraform setup automates the deployment of core AWS services. It's designed to provide a secure and isolated network environment (VPC), a managed Kubernetes service for container orchestration (EKS), and a NoSQL document database (DocumentDB) for your applications.

---

## Modules Used

### VPC Module

**Source:** `./modules/vpc`

This module provisions the networking layer, including:

- A new Virtual Private Cloud (VPC) with a specified CIDR block  
- Public subnets across multiple Availability Zones (AZs)  
- Private application subnets for application instances  
- Private data subnets for databases, ensuring isolation  
- Internet Gateway, NAT Gateways, and Route Tables for connectivity

---

### EKS Module

**Source:** `./modules/eks`

This module sets up an Amazon EKS cluster, including:

- EKS control plane with a defined Kubernetes version  
- Managed Node Group using EC2 instances  
- Private application subnets for the EKS worker nodes

---

### DocumentDB Module

**Source:** `./modules/documentdb`

This module provisions an Amazon DocumentDB cluster:

- DocumentDB Subnet Group for network placement  
- DocumentDB Cluster identified by a unique name  
- Private data subnets to isolate the database layer

---

## Prerequisites

Ensure the following tools are installed and configured:

- **AWS CLI**: Configured with valid credentials  
  ```bash
  aws configure
  ```

- **Terraform**: Version 0.13 or higher  
  ```bash
  brew install terraform  # macOS
  ```

- **AWS Account**: With permissions to manage VPC, EKS, and DocumentDB resources

---

## Usage

1. **Clone the Repository**  
   ```bash
   git clone <your-repo-url>
   cd <your-repo-directory>
   ```

2. **Initialize Terraform**  
   ```bash
   terraform init
   ```

3. **Review the Plan**  
   ```bash
   terraform plan --var-file=terraform.tfvars
   ```

4. **Apply the Configuration**  
   ```bash
   terraform apply --var-file=terraform.tfvars
   ```

5. **Destroy Resources (Optional)**  
   ```bash
   terraform destroy
   ```

---

## Variables

The configuration is parameterized using input variables defined in `main.tf`. You can set them in a `terraform.tfvars` file or pass them via CLI.

| Variable Name               | Description                                                     | Example             |
|----------------------------|-----------------------------------------------------------------|---------------------|
| `region`                   | The AWS region to deploy resources                              | `us-east-1`         |
| `aws_vpc_cidr_block`       | CIDR block for the main VPC                                     | `10.0.0.0/16`       |
| `private_app_subnet_az1_cidr` | CIDR block for private app subnet in AZ1                     | `10.0.1.0/24`       |
| `private_app_subnet_az2_cidr` | CIDR block for private app subnet in AZ2                     | `10.0.2.0/24`       |
| `private_data_subnet_az1_cidr` | CIDR block for private data subnet in AZ1                  | `10.0.3.0/24`       |
| `private_data_subnet_az2_cidr` | CIDR block for private data subnet in AZ2                  | `10.0.4.0/24`       |
| `public_subnet_az1_cidr`   | CIDR block for public subnet in AZ1                             | `10.0.5.0/24`       |
| `public_subnet_az2_cidr`   | CIDR block for public subnet in AZ2                             | `10.0.6.0/24`       |
| `project_name`             | Name tag for AWS resources                                      | `my-application`    |
| `eks_cluster_name`         | Name of the EKS cluster                                         | `my-eks-cluster`    |
| `eks_version`              | Kubernetes version for the EKS cluster                          | `1.28`              |
| `node_group_name`          | Name of the EKS Node Group                                      | `my-node-group`     |
| `docdb_subnet_group_name`  | Name of the DocumentDB Subnet Group                             | `my-docdb-subnet-group` |
| `docdb_cluster_idendifier` | Identifier for the DocumentDB cluster                           | `my-docdb-cluster`  |

---


