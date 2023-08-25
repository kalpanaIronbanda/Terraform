provider "aws" {
  region     = "us-west-1"
} 


#terraform import aws_instance.ec2_example i-09f31ad98d28e6f64
resource "aws_instance" "ec2_example" {
    ami = "ami-09f67f6dc966a7829"
    instance_type = "t2.micro" 
    tags = {
        Name = "import test"
    }    
}