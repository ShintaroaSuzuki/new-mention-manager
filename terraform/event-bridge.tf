resource "aws_cloudwatch_event_rule" "mention_manager_lambda_event_rule" {
  name = "mention_manager_lambda_event_rule"
  schedule_expression = "cron(0 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "mention_manager_lambda_target" {
  arn = aws_lambda_function.mention_manager.arn
  rule = aws_cloudwatch_event_rule.mention_manager_lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mention_manager.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.mention_manager_lambda_event_rule.arn
}
