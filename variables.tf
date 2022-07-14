variable "dmarc_email" {
  description = "Email address for capturing DMARC aggregate reports."
}

variable "domain_name" {
  description = "The domain name to configure SES. Must be a top level, FQDN."
}

variable "route53_zone_id" {
  description = "Route53 host zone ID to enable SES."
}