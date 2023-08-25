provider "aws" {
  region     = "us-west-1"
#   access_key = "AKIA4ZSRQ2ZEYLLNFJWO"
#   secret_key = "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"
}
#here s3 bucket and dynamodb_table which are used for backend to store tfstate file are created manually if you want you can create this with terraform but don't combine with regular resources (use seperate configuration or create manually)
terraform {
  backend "s3" {
    bucket = "sathishdestistation"
    key    = "terraform/remote/s3/terraform.tfstate"
    region = "us-west-1"
    encrypt = "true"
    dynamodb_table = "terraform_locks"
  }
}



resource "aws_instance" "ec2_example" {
  ami           = "ami-09f67f6dc966a7829"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform EC2 dynamodb"
  }
}

# resource "aws_s3_bucket" "thanshi_bucket" {
#   bucket = "example-terraform-bucket-thanshi-23"
#   acl    = "private"  # Access control settings ("private" is the default)
# }