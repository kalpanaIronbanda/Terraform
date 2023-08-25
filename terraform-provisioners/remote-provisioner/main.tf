provider "aws" {
  region = "us-west-1"
  #   access_key = "AKIA4ZSRQ2ZEYLLNFJWO"
  #   secret_key = "bc+wPTjuMN9L5kRsvQPFLTljC8qgTX/jiDhwaQWE"
}

resource "aws_instance" "ec2_example" {

  ami                    = "ami-09f67f6dc966a7829"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.example.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
  }
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Example security group for ssh connection"

  // Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4pC5+ZXZrUi36vq+6wh2j2ZI5nprl6vjvKJWisITP2+JGamSqSqGrjDJq5neP5fhGTzxkWi01GiUbNdFBWRiw2R8yr1wcvFRsE1wOed5BI26SBZYfDSuHmQjTUp9JbGTPlsstBcAOhjBAqRR/pMDvu9bC2rygED4Oi3A6JUDHf5PElEJrEpZDFNoEuLxbiwV929EB2pLYI2nl05QtQ2ZI4J+zjvhTC4L8NiBfLwvrkp2a/R5h8kTZd35S/jbWws4vm/JHHxQ6wVatI8L4LhsDIz2bDmz+Omca7yvN1BbGvZrqFqZMkyR5E9Sq9oAh1hUMyXIUZvCOmXqyNyUwNjhu9Cq2+RetAHwWVPSgUc+WPKvrCMB7xLfqSIvhJHZsS5c+5A0uZWZihzeNchsjOJA6Ee8BhZF3uusbC2VkmjfLiZ+6tGSu1Ao+7O+d5aWPOsOI9hzt1Rssr+vw6hS87Pftu2CMqNiAKfz1Ea9K4sXYMcPVEMA3TFxJgzmSsbPwh5k= Anil@DESKTOP-DIPCI8J"
}
