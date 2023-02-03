# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# Set these as environment variables in your terraform cloud environment
# ---------------------------------------------------------------------------------------------------------------------

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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------


# frontend variables
variable "bucket_name" {
  description = "The name of the s3 bucket containing the website code"
  default     = "terraform-website"
  type        = string
}

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "dev"
}

# dns variables

