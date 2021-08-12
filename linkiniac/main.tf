resource "aws_instance" "iacdemoec2" {

  availability_zone = var.az
  ami               = "ami-09e67e426f25ce0d7" # ubuntu 20 image
  instance_type     = "t2.micro"
  tags              = { Name = var.instance_name }
  key_name          = "awseducateiacdemo"
  security_groups = [ aws_security_group.sg_allow_all_egress_awseducateicademo.name ,
  aws_security_group.sg_allow_ssh_ingress_awseducateicademo.name , 
  aws_security_group.sg_allow_http_ingress_awseducateicademo.name]

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp2"
    tags = {
      Name = "iacdemorootebs"
    }
  }


}

output "instance_ip_addr" {
  value = aws_instance.iacdemoec2.public_ip
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