locals {
  bucket_name   = "super-unique-terraform-bucket"
  s3_bucket_arn = "arn:aws:s3:::${local.bucket_name}"
}

# Define the AWS provider
provider "aws" {
  region = var.region 
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = local.bucket_name
  tags = {
    Name        = "My bucket from ${local.bucket_name}"
    Environment = "Dev"
  }
}

# Create an IAM role for the EC2 instance
resource "aws_iam_role" "instance_role" {
  name = "s3-instance-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole",
    }],
  })
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "example_instance_profile" {
  name = "s3-instance-profile"
  role = aws_iam_role.instance_role.name
}

# Create an IAM policy for writing to the S3 bucket
resource "aws_iam_policy" "s3_write_policy" {
  name        = "s3_write_policy"
  description = "Allows writing objects to S3 bucket"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "s3:PutObject",
      Resource = local.s3_bucket_arn,
    }],
  })
}

# Attach an IAM policy to the role to allow writing to S3 bucket
resource "aws_iam_role_policy_attachment" "s3_write_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

# Create an EC2 instance
resource "aws_instance" "example_instance" {
  ami           = var.ami_id 
  instance_type = var.instance_type

  # Associate the IAM role with the instance
  iam_instance_profile = aws_iam_instance_profile.example_instance_profile.name

  # Example of user data to upload file to S3 bucket
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World!" > /tmp/example.txt
    aws s3 cp /tmp/example.txt s3://${local.bucket_name}/
  EOF
}
