resource "aws_ses_domain_identity" "domain_id" {
  domain = var.domain_name
}

resource "aws_ses_domain_identity_verification" "id_verification" {
  count      = var.enable_verification ? 1 : 0
  domain     = aws_ses_domain_identity.domain_id.id
  depends_on = [aws_route53_record.ses_verification]
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.domain_id.domain
}

resource "aws_ses_domain_mail_from" "mail_from" {
  domain           = aws_ses_domain_identity.domain_id.domain
  mail_from_domain = "ses.${aws_ses_domain_identity.domain_id.domain}"
}
