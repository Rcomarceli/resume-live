# resume-live
This repo houses the code I use to deploy the serverless architecture behind my web-hosted resume! It's a culmination of all my efforts of going through the cloud resume challenge (via AWS), and utilizes the following technologies:
- AWS S3, Lambda, Api Gateway, DynamoDB, Cloudwatch, IAM, IAM SSO, Org CLI Formation
- Cloudflare and Cloudflare Workers (DNS and Edge computing)
- Terraform and Terraform Cloud (For deploying the above AWS and Cloudflare resources as IaC!)
- Terratest, TFLint, and Cypress (for testing Terraform modules in my module repo)
- Github Actions (CI/CD Pipeline) and OIDC
- HTML, CSS, and Javascript (for the actual website code)
- Python (AWS Lambda), Javascript (website and Cypress), and Golang (terratest)

At a high level, the flow goes like this:
- I make a change to the code in this repo (either via push or pull request) That'll kick off my CI/CD pipeline (Github Actions) and run through static analysis tests just to check if the new code has any obvious errors. 
- Then, Git
