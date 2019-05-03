resource "aws_iam_user" "SMTP" {
  name = "outbound-mail"
  path = "/"
}

resource "aws_iam_access_key" "SMTP" {
  user = "${aws_iam_user.SMTP.name}"
}

resource "aws_iam_user_policy" "SMTP_ro" {
  name = "AmazonSesSendingAccess"
  user = "${aws_iam_user.SMTP.name}"

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
