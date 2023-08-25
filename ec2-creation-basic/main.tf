provider "aws" {
  region     = "us-west-1"
  access_key = "AKIA4ZSRQ2ZEYLLNFJWO"
  secret_key = "bc+wPTjuMN9L5kRsvQPFLTljC8qgTX/jiDhwaQWE"
} 

resource "aws_instance" "ec2_example" {
    ami = "ami-09f67f6dc966a7829"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }
}