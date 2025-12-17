resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-pipeline-alerts"
}

# Subscribe your email to the topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email # We will pass this from variables
}

# Allow EventBridge to publish messages to this SNS topic
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.alerts.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowEventsToPublish"
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = "sns:Publish"
        Resource  = aws_sns_topic.alerts.arn
      }
    ]
  })
}