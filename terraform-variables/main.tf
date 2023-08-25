provider "aws" {
  region     = "us-west-1"
  access_key = "AKIA4ZSRQ2ZEYLLNFJWO"
  secret_key = "bc+wPTjuMN9L5kRsvQPFLTljC8qgTX/jiDhwaQWE"
} 

resource "aws_instance" "ec2_example" {
    ami = "ami-09f67f6dc966a7829"  
    #1.string type variable
    instance_type = var.instance_type 
    #2.Number type variable
#    count = var.instance_count
    #3.Boolean type variable
#    associate_public_ip_address = var.enable_public_ip
    tags = var.name_environment
}

# #this resource is for list variable type (creating iam users)
# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }
