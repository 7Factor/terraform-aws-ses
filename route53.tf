resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = var.route53_zone_id
  name    = format("%s._domainkey.%s", element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index), var.domain_name)
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_verification" {
  zone_id = var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.domain_id.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.domain_id.verification_token]
}
