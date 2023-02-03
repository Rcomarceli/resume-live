output "website_endpoint" {
  value       = module.frontend.website_endpoint
  description = "The endpoint of the website s3 bucket"
}

output "api_url" {
  description = "URL to be put into the index.html javascript portion"

  value = module.backend.api_url
}

