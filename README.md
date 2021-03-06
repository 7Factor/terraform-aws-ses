Configures a domain hosted on Route53 to work with AWS Simple Email Service (SES)

## Prerequisites
* Ensure [terraform](https://www.terraform.io/intro/getting-started/install.html) is installed
* Ensure domain is registered in [route53](https://aws.amazon.com/route53/)
* Ensure an s3 bucket exists and SES has write permissions to it
* If you have an existing rule set you can skip creating the dependent resource
* route53 zone id can be obtained by looking up the domain in route53 service

## Getting Started
1. Import the module called `ses_domain` and update its source property to `7Factor/terraform-aws-ses` and run `terrafrom init`
2. The next step is to configure the module with [minimum values](#usage) for SES to start working
3. Once fully configured run `terraform plan` to see the execution plan and `terrafrom apply` to stand up SES

**Creates the following resources:**

* MX record pointing to AWS's SMTP endpoint
* TXT record for SPF validation
* Custom MAIL FROM domain
* CNAME records for DKIM verification
* SES Verfication for the domain

### NOTES: 
* SES is only available in us-east-1, us-west-2, and eu-west-1
* SES out of the box locks the service in development mode; please see this documentation on how to make it production ready. Until the service is in production mode you can only send emails to confirmed email accounts denoted in `from_addresses`

## Usage

```hcl
module "ses_domain" {
  source             = "github.com/7factor/terraform-aws-ses"
  domain_name        = "example.com"
  mail_from_domain   = "email.example.com"
  route53_zone_id    = "${data.aws_route53_zone.SES_domain.zone_id}"
  from_addresses     = ["email1@example.com", "email2@example.com"]
  dmarc_rua          = "something@example.com"
  ses_rule_set       = "name-of-the-ruleset"
}

resource "aws_ses_receipt_rule_set" "name-of-the-ruleset" {
  rule_set_name = "name-of-the-ruleset"
}

data "aws_route53_zone" "SES_domain" {
  name = "example.com"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dmarc_rua | Email address for capturing DMARC aggregate reports. | string | - | yes |
| domain_name | The domain name to configure SES. | string | - | yes |
| enable_verification | Control whether or not to verify SES DNS records. | string | `true` | no |
| from_addresses | List of email addresses to catch bounces and rejections | list | - | yes |
| mail_from_domain | Subdomain (of the route53 zone) which is to be used as MAIL FROM address | string | - | yes |
| route53_zone_id | Route53 host zone ID to enable SES. | string | - | yes |
| ses_rule_set | Name of the SES rule set to associate rules with. | string | - | yes |
