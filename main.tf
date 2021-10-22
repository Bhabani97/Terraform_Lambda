

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.iam_for_lambda.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
  "Version": "2012-10-17",
  {
      "Action": "logs:*",
    
    }
  ]
})
}

data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/hello.py"
  output_path = "${path.module}/files/hello.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${path.module}/files/hello.zip"
  function_name = "welcome"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "hello.welcome"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
 # source_code_hash = filebase64sha256("${path.module}/files/hello.zip")

  runtime = "python3.7"

 
}
