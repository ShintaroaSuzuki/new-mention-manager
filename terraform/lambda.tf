data "archive_file" "mention_manager_zip" {
  type = "zip"
  source_dir = "${path.module}/../dist"
  output_path = "lambda/mention_manager.zip"
}

resource "aws_lambda_function" "mention_manager" {
  function_name = "mention_manager"
  handler = "index.handler"
  filename = "${data.archive_file.mention_manager_zip.output_path}"
  runtime = "nodejs16.x"
  role = "${aws_iam_role.lambda_iam_role.arn}"
  source_code_hash = "${data.archive_file.mention_manager_zip.output_base64sha256}"
  environment {
    variables = {
      SLACK_BOT_TOKEN  = var.slack_bot_token
      SLACK_USER_TOKEN = var.slack_user_token
      SLACK_CHANNEL_ID = var.slack_channel_id
      REACTION_NAME    = var.reaction_name
      USER_NAME        = var.user_name
    }
  }
  timeout = 30
}
