provider "aws" {
  region     = var.region
  access_key = "AKIA4ZSRQ2ZEYLLNFJWO"
  secret_key = "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"
} 

# locals {
#   dev_env = var.env
# }

resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.dev_env}-vpc-tag"
  }
}

resource "aws_subnet" "staging-subnet" {
  vpc_id = aws_vpc.staging-vpc.id
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.dev_env}-subnet-tag"
  }
}

resource "aws_instance" "ec2_example" {
   
   ami           = "ami-09f67f6dc966a7829"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.staging-subnet.id
   associate_public_ip_address = var.enable_public_ip   
   tags = {
           Name = "${local.dev_env}-Terraform EC2"
   }
}
