resource "aws_ses_domain_identity" "main" {
  domain = "${local.stripped_domain_name}"
}

resource "aws_ses_domain_identity_verification" "main" {
  count = "${var.enable_verification ? 1 : 0}"

  domain = "${aws_ses_domain_identity.main.id}"

  depends_on = ["aws_route53_record.ses_verification"]
}

resource "aws_ses_domain_dkim" "main" {
  domain = "${aws_ses_domain_identity.main.domain}"
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = "${aws_ses_domain_identity.main.domain}"
  mail_from_domain = "${local.stripped_mail_from_domain}"
}