
# VPC
resource "aws_vpc" "vpcawseducateiacdemo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc_awseducateiacdemo"
  }
}

# Public subnet
resource "aws_subnet" "publicsubnetawseducateiacdemo" {
  vpc_id                  = aws_vpc.vpcawseducateiacdemo.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

}

# Private subnet

resource "aws_subnet" "privatesubnetawseducateiacdemo" {
  vpc_id     = aws_vpc.vpcawseducateiacdemo.id
  cidr_block = "10.0.2.0/24"
}

#IGW

resource "aws_internet_gateway" "igwawseducatedemoiac" {
  vpc_id = aws_vpc.vpcawseducateiacdemo.id
  tags = {
    "Name" = "igw_awseducateiacdemo"
  }
}

#for nat gateway to enable internet to private subnet
resource "aws_eip" "privateec2nat" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.privateec2nat.id
  # NATGW lives in public subnet 
  subnet_id = aws_subnet.publicsubnetawseducateiacdemo.id

  tags = {
    "Name" = "natgw_awseducateiacdemo"
  }

}

# custom public route table for public subnet
resource "aws_route_table" "custompublicrtawseducatedemoiac" {
  vpc_id = aws_vpc.vpcawseducateiacdemo.id


  route {
    cidr_block = "0.0.0.0/0"
    # directs to IGW
    gateway_id = aws_internet_gateway.igwawseducatedemoiac.id
  }


  tags = {
    "Name" = "custom_public_route_table_awseducatedemoiac"
  }
}

# custom private route table for private subnet

resource "aws_route_table" "customprivatertawseducatedemoiac" {
  vpc_id = aws_vpc.vpcawseducateiacdemo.id

  route {
    cidr_block = "0.0.0.0/0"
    # directs to NAT
    gateway_id = aws_nat_gateway.natgw.id
  }


  tags = {
    "Name" = "custom_private_route_table_awseducatedemoiac"
  }
}


# route table association for public subnet

resource "aws_route_table_association" "racawseducatedemoiac" {
  subnet_id      = aws_subnet.publicsubnetawseducateiacdemo.id
  route_table_id = aws_route_table.custompublicrtawseducatedemoiac.id
}

# route table association for private subnet

resource "aws_route_table_association" "racprivateawseducatedemoiac" {
  subnet_id      = aws_subnet.privatesubnetawseducateiacdemo.id
  route_table_id = aws_route_table.customprivatertawseducatedemoiac.id
}

# security group private for private subnet ec2

resource "aws_security_group" "sg_private_awseducateicademo" {
  name = "sg_private_awseducateicademo"

  vpc_id = aws_vpc.vpcawseducateiacdemo.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # postgres DB
  ingress {
    description      = "http"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

# security group public for private subnet ec2

resource "aws_security_group" "sg_public_awseducateicademo" {
  name = "sg_public_awseducateicademo"

  vpc_id = aws_vpc.vpcawseducateiacdemo.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


output "nat_gw_elastic_ip" {
  value = aws_eip.privateec2nat.public_ip
}
# resource "aws_key_pair" "privatekeyviabastion" {
#   key_name = "privatekeyec2"

# }

