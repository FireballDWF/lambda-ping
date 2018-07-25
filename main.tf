provider "aws" {
  region = "us-east-1" # "${var.region}"
}

variable "lambda-archive-name" {
  type = "string"
  default = "lambda-ping.zip"
}

data "aws_iam_role" "lambda-basic" {
  name = "lambda_basic_execution"
}

resource "aws_lambda_function" "mylambda" {
  description      = "Check response code & latency of remote endpoints and graph in CloudWatch"
  filename         = "${var.lambda-archive-name}"
  function_name    = "lambda_function_name"
  role             = "${data.aws_iam_role.lambda-basic.arn}"
  handler          = "handler.http"
  source_code_hash = "${base64sha256(file(var.lambda-archive-name))}"
  runtime          = "nodejs6.10"
  timeout          = "30"  # seconds
  memory_size      = "128" # MB
  # vpc_config

  environment {
    variables = {
      foo = "bar"
    }
  }
}