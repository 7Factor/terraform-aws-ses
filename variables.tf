variable "dmarc_rua" {
  description = "Email address for capturing DMARC aggregate reports."
}

variable "domain_name" {
  description = "The domain name to configure SES. Must be a top level, FQDN."
}

variable "enable_verification" {
  default     = true
  description = "Control whether or not to verify SES DNS records. Defaults to true."
}

variable "route53_zone_id" {
  description = "Route53 host zone ID to enable SES."
}

variable "mx_receive_records" {
  type        = list(string)
  default     = ["10 inbound-smtp.us-east-1.amazonaws.com"]
  description = "Route53 MX record which defines vaild mail servers. Defaults to `10 inbound-smtp.us-east-1.amazonaws.com`."
}

variable "spf_records" {
  type        = list(string)
  default     = ["v=spf1 include:amazonses.com -all"]
  description = "Route53 MX record which defines vaild mail servers. Defaults to `v=spf1 include:amazonses.com -all`"
}