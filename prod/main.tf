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
      name = "prod-resume"
    }
  }
}


# bucket names have a dash instead since an underscore is invalid
resource "random_pet" "website_bucket_name" {
  prefix = "${var.environment}-${var.website_bucket_name}"
  length = 3
}

resource "random_pet" "lambda_bucket_name" {
  prefix = "${var.environment}-${var.lambda_bucket_name}"
  length = 3
}


module "backend" {
  source = "github.com/Rcomarceli/resume-modules//backend?ref=v1.0.3"

  scope_permissions_arn       = var.scope_permissions_arn
  update_visitor_counter_path = var.update_visitor_counter_path
  lambda_bucket_name          = random_pet.lambda_bucket_name.id
  database_name               = "${var.environment}_${var.database_name}"
  cloudflare_domain           = var.cloudflare_domain
  function_name               = "${var.environment}_${var.function_name}"
  lambda_iam_role_name        = "${var.environment}_${var.lambda_iam_role_name}"
  lambda_iam_policy_name      = "${var.environment}_${var.lambda_iam_policy_name}"
  api_gateway_name            = "${var.environment}_${var.api_gateway_name}"
  api_gateway_stage_name      = "${var.environment}_${var.api_gateway_stage_name}"
  lambda_permission_name      = "${var.environment}_${var.lambda_permission_name}"
}

module "frontend" {
  source = "github.com/Rcomarceli/resume-modules//frontend?ref=v1.0.3"

  api_url             = module.backend.api_url
  website_bucket_name = random_pet.website_bucket_name.id
}

module "dns" {
  source = "github.com/Rcomarceli/resume-modules//dns?ref=v1.0.3"

  # cloudflare variables here are defined in the terraform cloud org 
  # as environment variables
  environment           = var.environment
  cloudflare_zone_id    = var.cloudflare_zone_id
  cloudflare_domain     = var.cloudflare_domain
  cloudflare_account_id = var.cloudflare_account_id
  website_endpoint      = module.frontend.website_endpoint
}

module "www" {
  source = "github.com/Rcomarceli/resume-modules//www?ref=v1.0.0"

  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_domain  = var.cloudflare_domain
}

# testing out rate limiting rule configured here. it is not included as a module because this project was intended as free tier only. 
# this requires zone, zone waf edit permissions.
resource "cloudflare_rate_limit" "example" {
  zone_id   = var.cloudflare_zone_id
  threshold = 10
  period    = 5
  # match {
  #   request {
  #     url_pattern = "${var.cloudflare_zone}/"
  #     schemes     = ["HTTP", "HTTPS"]
  #     methods     = ["GET", "POST", "PUT", "DELETE", "PATCH", "HEAD"]
  #   }
  # }
  action {
    mode    = "simulate"
    timeout = 10
    response {
      content_type = "text/plain"
      body         = "custom response body"
    }
  }
  correlate {
    by = "nat"
  }
  description = "example rate limit for a zone"
}