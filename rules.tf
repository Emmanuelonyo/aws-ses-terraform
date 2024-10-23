# ses rule set
resource "aws_ses_receipt_rule_set" "ms" {
  rule_set_name = "ms_receive_all"
}

resource "aws_ses_active_receipt_rule_set" "ms" {
  rule_set_name = aws_ses_receipt_rule_set.ms.rule_set_name

  depends_on = [
    aws_ses_receipt_rule.ms,
  ]
}

resource "aws_s3_bucket_policy" "ms_ses" {
  bucket = aws_s3_bucket.ms.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:*"]

    resources = [
      aws_s3_bucket.ms.arn,
      "${aws_s3_bucket.ms.arn}/*",
    ]
  }
}
# lambda catch all
resource "aws_ses_receipt_rule" "ms" {
  name          = "ms"
  rule_set_name = aws_ses_receipt_rule_set.ms.rule_set_name

  recipients = [
    "${var.domain}",
  ]

  enabled      = true
  scan_enabled = true

  s3_action {
    bucket_name = aws_s3_bucket.ms.bucket
    # topic_arn   = aws_sns_topic.ms2.arn
    position = 1
  }

  stop_action {
    scope    = "RuleSet"
    position = 2
  }

  depends_on = [aws_s3_bucket.ms, aws_s3_bucket_policy.ms_ses]
}