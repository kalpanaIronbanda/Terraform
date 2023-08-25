variable "env" {}
variable "region" {
   type = string
   description = "The project region"
   default = "us-west-1"
}

#3.Boolean variable type 
variable "enable_public_ip" {
  description = "Enable public IP address"
  type        = bool
  default     = true
}