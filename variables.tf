variable "dmarc_rua" {
  description = "Email address for capturing DMARC aggregate reports."
  type        = string
}

variable "domain_name" {
  description = "The domain name to configure SES."
  type        = string
}

variable "enable_verification" {
  description = "Control whether or not to verify SES DNS records. Defaults to true."
  type        = string
  default     = true
}

variable "from_addresses" {
  description = "List of email addresses to catch bounces and rejections"
  type        = list(string)
}

variable "mail_from_domain" {
  description = " Subdomain (of the route53 zone) which is to be used as MAIL FROM address"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 host zone ID to enable SES."
  type        = string
}

variable "mx_receive_records" {
  description = "Route53 MX record which defines vaild mail servers. Defaults to `10 inbound-smtp.us-east-1.amazonaws.com`."
  type        = list(string)
  default     = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}

variable "spf_records" {
  description = "Route53 MX record which defines vaild mail servers. Defaults to `v=spf1 include:amazonses.com -all`"
  type        = list(string)
}
