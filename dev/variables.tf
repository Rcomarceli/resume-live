# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# Set these as environment variables in your terraform cloud environment
# ---------------------------------------------------------------------------------------------------------------------

# dns variables

variable "cloudflare_zone_id" {
  description = "Zone ID for Cloudflare Domain"
  type        = string
}

variable "cloudflare_domain" {
  description = "Domain name to be used for accessing the website"
  type        = string
}

variable "cloudflare_api_token" {
  description = "token used for cloudflare. defined in terraform cloud"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "The account ID for Cloudflare"
  type        = string
}

# backend variables

variable "scope_permissions_arn" {
  description = "ARN of the permission boundary that *should* be on the terraform user"
  type        = string
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

# global variables

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "dev"
}

# frontend variables
variable "website_bucket_name" {
  description = "The name of the s3 bucket containing the website code"
  default     = "resume-website"
  type        = string
}

# backend variables
variable "update_visitor_counter_path" {
  description = "Website API route to increment the visitor counter"
  default     = "updateVisitorCounter"
  type        = string
}

variable "lambda_bucket_name" {
  description = "The name of the s3 bucket containing the lambda code"
  default     = "resume-lambda"
  type        = string
}

variable "database_name" {
  description = "Name of the DB used to hold the visitor counter"
  default     = "resume_db"
  type        = string
}

variable "function_name" {
  description = "Lambda Function Name"
  default     = "updatevisitorcounter"
  type        = string
}

variable "lambda_iam_role_name" {
  description = "Name for Lambda IAM Role. Used for permissions for the lambda function"
  default     = "Lambda_iam_role"
  type        = string
}

variable "lambda_iam_policy_name" {
  description = "Name for Lambda IAM Policy. Attached to Lambda Role"
  default     = "Lambda_Iam_Policy"
  type        = string
}

variable "api_gateway_name" {
  description = "Name for API Gateway"
  default     = "resume_api"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Name for API Gateway Stage"
  default     = "v1"
  type        = string
}

variable "lambda_permission_name" {
  description = "Name for lambda permission"
  default     = "lambda_permission"
  type        = string
}