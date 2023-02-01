terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    # cloudflare = {
    #   source  = "cloudflare/cloudflare"
    #   version = "~> 3.0"
    # }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Terraform   = true
      Environment = var.environment
    }
  }
}

# provider "cloudflare" {
#   api_token = var.cloudflare_api_token
# }

# backend
terraform {

  cloud {
    organization = "rcomarceli-tutorial"

    workspaces {
      name = "dev-resume-sandbox"
    }
  }

}

resource "random_pet" "website_bucket_name" {
  prefix = "terraform-website"
  length = 4
}
