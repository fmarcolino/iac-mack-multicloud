locals {
  aws_region   = "us-east-1"
  azure_region = "East US"

  tags = {
    Project     = "Mackenzie Iac"
    Owner       = "Francisco Rodrigues"
    Environment = terraform.workspace
  }
}
