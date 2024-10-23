# resource "aws_sns_topic" "ms2" {
#   name = "ms2-receipt-sns"
# }

# resource "aws_sns_topic_subscription" "ms2_receive" {
#   topic_arn = "${aws_sns_topic.ms2.arn}"
#   protocol  = "lambda"
#   endpoint  = "${aws_lambda_function.ms_receive_mail.arn}"
# }

# resource "aws_sns_topic" "ms2_ses_error" {
#   name = "ms2-ses-error"
# }