# resume-live
This repo ([along with the module repo](https://github.com/Rcomarceli/resume-modules)) houses the code I use to deploy the serverless architecture behind my [web-hosted resume](https://rcmarceli.com)! It's a culmination of all my efforts of going through the [cloud resume challenge](https://cloudresumechallenge.dev/docs/the-challenge/aws/) (via AWS), and utilizes the following technologies:
- AWS S3, Lambda, Api Gateway, DynamoDB, Cloudwatch, IAM, IAM SSO, Org CLI Formation
- Cloudflare and Cloudflare Workers (DNS and Edge computing)
- Terraform and Terraform Cloud (For deploying the above AWS and Cloudflare resources as IaC!)
- Terratest, TFLint, and Cypress (for testing Terraform modules in my module repo)
- Github Actions (CI/CD Pipeline) and OIDC
- React/Vite: HTML, CSS, and Javascript (for the actual website code)
- Python (AWS Lambda), Javascript (website and Cypress), and Golang (terratest)

Also see my writeup [here!](https://www.linkedin.com/pulse/cloud-resume-challenge-how-i-used-terraform-aws-deploy-roy-marcelino)

At a high level, the flow goes like this:
- I make a change to the code in this repo (either via push or pull request) That'll kick off my CI/CD pipeline (Github Actions) download the required, tested versions of the terraform modules I've made at [my module repo](https://github.com/Rcomarceli/resume-modules) and run the whole code through static analysis tests just to check if the new code has any obvious errors. 
- If those tests pass, then Terraform will form output a preview/plan to deploy the updated code/cloud resources to AWS or Cloudflare. If the whole process was kick started by a pull request, it'll stop here and I can review the plan. If I merge this pull request into the main repo, or just pushed it directly to main from the start (which I probably shouldn't be doing), then it'll go ahead and deploy those changes to Cloudflare and/or AWS.
- After the changes, we employ a smoke/e2e test to ensure we can navigate to the site via our desired domain name, and that the dynamic visitor counter is working.
- If all tests pass, our new code is successfully tested and integrated, and I can rest easy knowing that the changes I've made haven't broken the site! 

