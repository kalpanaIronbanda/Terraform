Terraform:
---------------
Terraform is a OpenSource infrastructure as a code software tool.
With the help of terraform we can provision infrastructure on Cloud like AWS,Azure,GCP..etc

Terraform Variables:
--------------------
Terraform variables are a way to store values that can be reused throughout your Terraform configuration.

They allow you to define a value once and reference it in multiple places throughout your configuration, making it easier to manage and update your infrastructure.

1. variables are defined in the variable block in the configuration file or in the seperate file like variable.tf
   
        variable "<your_variable_name>" {
          type = ""         #-------->type of the variable
          description = ""  #-------->description for it
          default = ""      #-------->default value which u want to pass
        }

2. Variables can be accessed in Terraform configuration files using the var function
   
        var.<your_variable_name>

3. Variables can have different types like string, boolean, number, list...ect
    

Types of variables:
-------------------
There are two main types simple values and collection variables

simple values : These are the variables which holds only single values
1. string --------ex: "t2.micro"
2. number---------ex: 2
3. boolean--------ex: true/false
   
Collection variables: These are the variables which holds more than one value
1. list ----------ex: ["user1","user2","user3"]
2. set 
3. map

map and set are key, value pair of strings
  
*.tfvars: This file is also used for the defining and declaring variable but can be used for the multiple environments like dev,stage,prod..etc

**Having a seperate *.tfvars for all re-usable variables provides clarity, readability and maintainability of code 


Terraform Locals:
------------------
Terraform locals are used to define values that are computed from expressions within your configuration
Terraform locals can help us to improve our terraform configuration file and centralize local variable configuration, so that we can change and update values at one place 
It can be useful to simplify the complex file.

Terraform output:
-----------------
Terraform output are useful for debugging purpose and explore/hide data like ip's,hostnames,..etc.

Terraform Functions:
-------------------
when we are working with collection variables like list,set and map we come across these functions like 
count,for each, for

count : it is used to create n no. of resources like ec2's,IAM users..etc

ex:
        variable "user_names" {
        description = "IAM usernames"
        type        = list(string)
        default     = ["user1", "user2", "user3"]
        }
        resource "aws_iam_user" "example" {
        count = length(var.user_names)
        name  = var.user_names[count.index]
        }

for_each: it is also used to create n no. of resources but it works with set variable type

ex:
        variable "user_names" {
        description = "IAM usernames"
        type        = set(string)
        default     = ["user1", "user2", "user3s"]
        } 
        resource "aws_iam_user" "example" {
        for_each = var.user_names
        name  = each.value
        }    

Q: What is the difference between for_each and count?

count works on list of strings and it creates n no. of resources by using same static data
for_each works on either map or set, so that it will create resoureces based the map or set of string values
for example : if we want to create 3 ec2's with count function, we can create with same ami,instance-type,vpc...like on but if want to create the ec2's with for_each function we must have map or set of string (i.e.ami id's) variable type and it will create new ec2's with taking one ami to one ec2
        
        # Iterate over the amis set defined in the variable 
        # The followig resource will create two ec2 instances. 
        resource "aws_instance" "example" {
        for_each      = var.ami_id
        ami           = each.value
        instance_type = "t2.micro"
        }

        variable "ami_id" {
        description = "IAM usernames"
        type        = set(string)
        default     = ["ami-0c55b159cbfafe1f0", "ami-083ac7c7ecf9bb9b0"]
        }

        # Following terraform code will create 3 instances of ec2
        resource "aws_instance" "example" {
        count = 3

        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
        }


Terraform Provisioners:
----------------------
Terraform Provisioners are used to performing certain custom actions and tasks either on the local machine or on the remote machine.

There are three types of provisioners
1.file                  |}

2.local_exec            |-------generic provisioner(these are independent of Cloud)

3.remote_exec           |}

1. File provisioner - The file provisioner will help you to copy the file securely from the local machine to the remote Ec2 instance.
  connection: This is a mandatory argument which you always need to pass along whenever you are implementing the file provisioner

2. Local provisioner - The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource. It will help you to run the shell command onto your local machine instead of the remote EC2 instance. (Running custom shell script on the local machine)
  command: This is a mandatory argument which you always need to pass along whenever you are implementing the local-exec provisioner

3. Remote provisioner - The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. It will help you to run the shell command onto the remote Ec2 instance of AWS.(Running custom shell script on the remote machine)
  inline: this is not a mandatory arguement bt if you want to run multiple commands on the remote machine we can use inline and this provision are also need connection arguement whenever we are going to use remote-exec


Terraform state:
---------------
terraform.tfstate file is a file which acts as database for the terraform configuration and it is created by terraform itself when the first terraform apply command is applied in the project directory and then it will record all the info whatever we did on terraform
For better practice store the terraform state file in the s3 

terraform state lock:
---------------------
terraform state lock help to overcome the conficts when multiple developers working on the same configuration files.
create a dynamodb table for lock and it will lock the terraform that other one not perform any action while another one working on it
terraform state lock is the better practice for broad teams.

depends_on meta-arguement:
--------------------------
depends_on metatag-arguement is used to define explicit dependency between the resources.It is used to specify that perticular resource depends on another resource and the depent resource should be created or modified before the resource that depends on it.


LifeCycle Rules:
----------------
syntax:

   resource "type" "name" {
   
     key1 = "value1"
     
     key2 = "value2"
     
     lifecyle {
     
       rule = true/false
       
     }  
     
   }
   
rules are below:

when we modify the existing resource, terraform will delete the existing one and then creates new one with modifications.
1. create_before_destroy ----- if we want to modify the resource before destroying it, then set it as true
2. prevent_destroy ----- if we don't want to destroy the existing resource at all and just want to modify it, then set it as true
3. ignore_changes ---- it accepts list of arguements to ignore the changes made to that arguements manually or with any other tool for subsequent applies
