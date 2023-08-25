#1.string variable type 
variable "instance_type" {
   description = "Instance type t2.micro"
   type        = string
   default     = "t2.micro"
} 

# #2.Number variable type (It is defined in the main.tf file with count function)
# variable "instance_count" {
#   description = "EC2 instance count"
#   type        = number
#   default     = 1
# }  

# #3.Boolean variable type 
# variable "enable_public_ip" {
#   description = "Enable public IP address"
#   type        = bool
#   default     = false
# }

# #4.List variable type 
# variable "user_names" {
#   description = "IAM usernames"
#   type        = list(string)
#   default     = ["user1", "user2", "user3"]
# }

#5.Map variable type
variable "name_environment" {
  description = "name and environment"
  type        = map(string)
  default     = {
    Name     = "project-alpha",
    environment = "dev"
  }
}

