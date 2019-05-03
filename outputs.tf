output "smtp_user_key" {
  description = "smtp user access key id"
  value       = "${aws_iam_access_key.smtp_user_access_key}"
}

output "smtp_user_key" {
  description = "smtp user secret"
  value       = "${aws_iam_access_key.smtp_user_access_key.secret}"
}
