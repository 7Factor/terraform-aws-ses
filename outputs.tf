output "smtp_user_name" {
  value = aws_iam_user.ses_user.name
}

output "smtp_user_access_id" {
  description = "Access key for SMTP user."
  value       = aws_iam_access_key.ses_access_key.id
}

output "smtp_user_secret" {
  description = "Password for SMTP user."
  value       = aws_iam_access_key.ses_access_key.ses_smtp_password_v4
}

output "dkim_tokens" {
  value = aws_ses_domain_dkim.dkim.dkim_tokens
}
