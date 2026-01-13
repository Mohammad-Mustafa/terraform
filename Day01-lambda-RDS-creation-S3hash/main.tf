resource "aws_s3_bucket" "name" {
  bucket = "s3for-rds-codeupload"

  tags = {
    Name        = "bucket01"
    Environment = "prod"
  }
}
resource "aws_s3_object" "lamda_code" {
  bucket = aws_s3_bucket.name.id
  key    = "app.zip"
  source = "app.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("app.zip")
}


# 1. Create IAM Role
resource "aws_iam_role" "s3_custom_role" {
  name = "s3-custom-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com" # Change if attaching to Lambda, ECS, etc.
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 2. Create Custom Policy for S3
resource "aws_iam_policy" "s3_custom_policy" {
  name        = "s3-custom-policy"
  description = "Custom policy for S3 bucket access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::my-bucket-name",
          "arn:aws:s3:::my-bucket-name/*"
        ]
      }
    ]
  })
}

# 3. Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.s3_custom_role.name
  policy_arn = aws_iam_policy.s3_custom_policy.arn
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          =  aws_iam_role.s3_custom_role.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.12"
  timeout       = 600
  memory_size   = 128
  filename = "app.zip"


  #source_code_hash = filebase64sha256("lambda_function.zip")

  #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

#This hash is a checksum that triggers a deployment.
}



