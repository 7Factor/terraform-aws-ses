resource "aws_ses_domain_identity" "domain_id" {
  domain = var.domain_name
}

resource "aws_ses_domain_identity_verification" "id_verification" {
  domain     = aws_ses_domain_identity.domain_id.id
  depends_on = [aws_route53_record.ses_verification]
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.domain_id.domain
}

# Per AWS:
# A verified identity is a domain, subdomain, or email address you use to send email through Amazon SES.
# Identity verification at the domain level extends to all email addresses under one verified domain identity.
# This means we should verify by top level domain unless we want subdomains here. We can always add subdomain
# support later if necessary. It would simply be a loop on the verification/mail_from pair.
resource "aws_ses_domain_mail_from" "mail_from" {
  domain           = aws_ses_domain_identity.domain_id.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.domain_id.domain}"
}
