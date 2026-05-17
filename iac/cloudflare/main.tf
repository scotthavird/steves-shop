terraform {
  required_version = ">= 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  # Backend configuration - local state for now. Uncomment and configure for team use.
  # See ../../havoptic.com/havoptic-scripts/iac/prod/main.tf for an S3 example.
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "cloudflare/steves-shop/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "main" {
  name = var.domain_name
}

locals {
  namespace = var.namespace
  zone_id   = data.cloudflare_zone.main.id
}
