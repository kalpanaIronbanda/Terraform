output "public_ip" {
    value = aws_instance.ec2_example.public_ip
    sensitive = true
}

#sensitive can used when we want to hide data like ip's, hostnames,..etc