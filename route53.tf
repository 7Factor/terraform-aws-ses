resource "aws_route53_record" "ses_verification" {
  zone_id = var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.domain_id.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.domain_id.verification_token]
}
