terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

}

provider "aws" {

  profile = "default"
  region  = "us-east-1"

}

resource "aws_security_group" "awseducateicademosg" {
  name = "awseducateicademosg"
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "iacdemoec2" {

  availability_zone = var.az
  ami               = "ami-09e67e426f25ce0d7" # ubuntu 20 image
  instance_type     = "t2.micro"
  tags              = { Name = var.instance_name }
  key_name          = "awseducateiacdemo"
  security_groups = [ aws_security_group.awseducateicademosg.name]

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp2"
    tags = {
      Name = "iacdemorootebs"
    }
  }

  #   security_groups = ["awseducateicademo"]

}

# resource "aws_ebs_volume" "iacdemoebs" {
#   availability_zone = var.az
#   size              = 8
#   depends_on = [
#     aws_instance.iacdemo
#   ]
#   type = "gp2"

#   tags = {
#     Name = "iacdemoebs"
#   }
# }

# resource "aws_volume_attachment" "attachebsec2" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.iacdemoebs.id
#   instance_id = aws_instance.iacdemo.id
#   depends_on = [
#     aws_instance.iacdemo, aws_ebs_volume.iacdemoebs
#   ]
# }