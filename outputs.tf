output "smtp_user_access_id" {
  description = "smtp user access key id"
  value       = "${aws_iam_access_key.smtp_user_access_key.id}"
}

output "smtp_user_secret" {
  description = "smtp user secret"
  value       = "${aws_iam_access_key.smtp_user_access_key.ses_smtp_password}"
}
