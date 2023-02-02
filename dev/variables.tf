# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

# variable "db_remote_state_bucket" {
#   description = "The name of the S3 bucket for the database's remote state"
#   type        = string
# }

# variable "db_remote_state_key" {
#   description = "The path for the database's remote state in S3"
#   type        = string
# }

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

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