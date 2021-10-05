resource "aws_iam_user" "ses_user" {
  name = "outbound-mail-for-${replace(var.domain_name, ".", "-")}"
  path = "/"
}

resource "aws_iam_access_key" "ses_access_key" {
  user = aws_iam_user.ses_user.name
}

resource "aws_iam_user_policy" "smtp_read_only" {
  name = "AmazonSesSendingAccess"
  user = aws_iam_user.ses_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
EOF
}
