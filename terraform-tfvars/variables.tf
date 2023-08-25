# variable.tf 

# No default value
variable "instance_type" {
   type = string
   description = "EC2 Instance Type"
}

# No default value
variable "tag" {}
variable "ami" {}

# default value for the variable location
variable "region" {
   type = string
   description = "The project region"
   default = "us-west-1"
}