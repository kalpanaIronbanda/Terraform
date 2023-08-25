provider "aws" {
  region     = "us-west-1"
} 

resource "aws_instance" "ec2_example" {
    ami = "ami-09f67f6dc966a7829"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }
  provisioner "local-exec" {
    command = "touch file.txt"
  }
}


