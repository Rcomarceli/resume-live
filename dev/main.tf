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
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
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

terraform {

  cloud {
    organization = "rcomarceli-tutorial"

    workspaces {
      name = "resume-backend-dev"
    }
  }
}


resource "random_pet" "website_bucket_name" {
  prefix = var.bucket_name
  length = 4
}

# tflint-ignore: all
module "frontend" {
  # tflint-ignore: all

  # source = "../../modules/frontend"
  source = "github.com/Rcomarceli/resume-modules//frontend"

  bucket_name = random_pet.website_bucket_name.id

  environment = var.environment
}