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