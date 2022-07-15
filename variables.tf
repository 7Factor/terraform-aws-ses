variable "dmarc_email" {
  description = "Email address for capturing DMARC aggregate reports."
}

variable "domain_name" {
  description = "The domain name to configure SES. Must be a top level, FQDN."
}

variable "mail_from_subdomain" {
  description = "The sub domain from where to send emails. Must be a valid subdomain of domain_name."
}

variable "route53_zone_id" {
  description = "Route53 host zone ID to enable SES."
}

variable "mx_records" {
  type        = list(string)
  default     = ["10 inbound-smtp.us-east-1.amazonaws.com"]
  description = "Route53 MX record which defines vaild mail servers. Defaults to `10 inbound-smtp.us-east-1.amazonaws.com`."
}

variable "spf_records" {
  type        = list(string)
  default     = ["v=spf1 include:amazonses.com -all"]
  description = "Route53 MX record which defines valid mail servers. Defaults to `v=spf1 include:amazonses.com -all`"
}