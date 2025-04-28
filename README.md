# AWS Infrastructure Setup with Terraform and GitHub Actions

This project demonstrates how to manage AWS infrastructure using Terraform and automate deployments using GitHub Actions. It includes importing existing AWS resources and managing them through Infrastructure as Code (IaC).

# Project Structure

- Infrastructure Setup/
  - apigateway.tf
  - backend.tf
  - dynamodb.tf
  - iam.tf
  - lambda.tf
  - main.tf
  - outputs.tf
  - provider.tf
  - variables.tf
  - .github/
    - workflows/
      - deploy.yaml

# Prerequisites

- AWS Account with Administrator access
- AWS CLI installed and configured
- Terraform installed (v1.11.3 or later)
- GitHub account
- Git installed

# Initial Setup

## Create Backend Infrastructure

```bash
# Create S3 bucket for Terraform state
aws s3api create-bucket  --bucket cloud-resume-challenge-backend  --region ap-south-1  --create-bucket-configuration LocationConstraint=ap-south-1

# Enable versioning
aws s3api put-bucket-versioning  --bucket cloud-resume-challenge-backend  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table  --table-name terraform-state-lock  --attribute-definitions AttributeName=LockID,AttributeType=S  --key-schema AttributeName=LockID,KeyType=HASH  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1  --region ap-south-1
```

# Configure GitHub Secrets

- Navigate to your GitHub repository → Settings → Secrets and variables → Actions
- Add the following secrets:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

# Importing Existing Resources

If you have existing AWS resources that you want to manage with Terraform:

## Generate Import Blocks

```bash
# Example for importing an existing S3 bucket
terraform import aws_s3_bucket.terraform_state cloud-resume-challenge-backend

# Example for importing DynamoDB table
terraform import aws_dynamodb_table.terraform_lock terraform-state-lock
```

## Update Terraform Configuration

- Add the imported resources to your Terraform configuration files
- Run `terraform plan` to ensure the imported state matches the configuration

# Terraform Configuration Files

## backend.tf

```hcl
terraform {
  backend "s3" {
    bucket = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

## provider.tf

```hcl
provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  required_version = ">= 1.11.3"
}
```

# GitHub Actions Workflow

The workflow automatically runs Terraform commands when changes are pushed to the main branch.

```yaml
name: "Terraform Deploy"

on:
  push:
    branches:
      - main

jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./Infrastructure Setup

    steps:
      # Workflow steps as defined in deploy.yaml
```

# Local Development

## Clone the repository

```bash
git clone <repository-url>
cd Infrastructure Setup
```

## Initialize Terraform

```bash
terraform init
```

## Make changes and test

```bash
terraform fmt
terraform validate
terraform plan
```

## Apply changes locally (if needed)

```bash
terraform apply
```

# Deployment Process

## Push changes to GitHub

```bash
git add .
git commit -m "Update infrastructure configuration"
git push origin main
```

## Monitor GitHub Actions

- Go to your GitHub repository
- Click on "Actions" tab
- Monitor the workflow execution

# Important Notes

- Always review the `terraform plan` output before applying changes
- Keep AWS credentials secure and never commit them to the repository
- Use `terraform fmt` to maintain consistent code formatting
- Update terraform state files only through the CI/CD pipeline
- Monitor AWS costs regularly

# Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
