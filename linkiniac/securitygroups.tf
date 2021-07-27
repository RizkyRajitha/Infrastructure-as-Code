resource "aws_security_group" "sg_allow_http_ingress_awseducateicademo" {
  name = "sg_allow_http_ingress_awseducateicademo"
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "sg_allow_ssh_ingress_awseducateicademo" {
  name = "sg_allow_ssh_ingress_awseducateicademo"

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "sg_allow_all_egress_awseducateicademo" {
  name = "sg_allow_all_egress_awseducateicademo"
 
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}