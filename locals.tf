locals {
  stripped_domain_name = "${replace(var.domain_name, "/[.]$/", "")}"

  stripped_mail_from_domain = "${replace(var.mail_from_domain, "/[.]$/", "")}"
  dash_domain               = "${replace(var.domain_name, ".", "-")}"
}