
resource "aws_instance" "ec2privateawseducateiacdemo" {

  # availability_zone = var.az
  ami                    = "ami-09e67e426f25ce0d7" # ubuntu 20 image
  instance_type          = "t2.micro"
  tags                   = { Name = var.private_instance_name }
  key_name               = "awseducateiacdemo"
  vpc_security_group_ids = [aws_security_group.sg_private_awseducateicademo.id]
  subnet_id              = aws_subnet.privatesubnetawseducateiacdemo.id

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp2"
    tags = {
      Name = "iacdemorootebs"
    }
  }

}

resource "aws_instance" "ec2publicawseducateiacdemo" {

  # availability_zone = var.az
  ami                    = "ami-09e67e426f25ce0d7" # ubuntu 20 image
  instance_type          = "t2.micro"
  tags                   = { Name = var.public_instance_name }
  key_name               = "awseducateiacdemo"
  vpc_security_group_ids = [aws_security_group.sg_public_awseducateicademo.id]
  subnet_id              = aws_subnet.publicsubnetawseducateiacdemo.id

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp2"
    tags = {
      Name = "iacdemorootebs"
    }
  }

}

output "public_instance_ip_addr" {
  value = aws_instance.ec2publicawseducateiacdemo.public_ip
}

output "private_instance_ip_addr" {
  value = aws_instance.ec2privateawseducateiacdemo.private_ip
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