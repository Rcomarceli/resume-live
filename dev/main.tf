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
      version = "~> 2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
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

# api token defined in terraform cloud
provider "cloudflare" {
  api_token = var.cloudflare_api_token
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
  prefix = var.website_bucket_name
  length = 4
}

resource "random_pet" "lambda_bucket_name" {
  prefix = var.lambda_bucket_name
  length = 4
}


module "backend" {
  source = "github.com/Rcomarceli/resume-modules//backend"

  scope_permissions_arn       = var.scope_permissions_arn
  update_visitor_counter_path = var.update_visitor_counter_path
  lambda_bucket_name          = random_pet.lambda_bucket_name.id
  database_name               = var.database_name
  cloudflare_domain           = var.cloudflare_domain
  function_name               = var.function_name
  lambda_iam_role_name        = var.lambda_iam_role_name
  lambda_iam_policy_name      = var.lambda_iam_policy_name
  api_gateway_name            = var.api_gateway_name
  api_gateway_stage_name      = var.api_gateway_stage_name
  lambda_permission_name      = var.lambda_permission_name
}

module "frontend" {
  # source = "../../modules/frontend"
  source = "github.com/Rcomarceli/resume-modules//frontend"

  api_url     = module.backend.api_url
  bucket_name = random_pet.website_bucket_name.id
  # environment = var.environment
}

module "dns" {
  source = "github.com/Rcomarceli/resume-modules//dns"

  # all defined in the terraform cloud org as environment variables
  environment        = var.environment
  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_domain  = var.cloudflare_domain
  # cloudflare_api_token  = var.cloudflare_api_token
  cloudflare_account_id = var.cloudflare_account_id
  website_endpoint      = module.frontend.website_endpoint
}