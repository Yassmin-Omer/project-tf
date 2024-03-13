output "ami_id" {
  value = data.aws_ami.linux-ami.image_id
}


output "sg_id" {
    value = aws_security_group.sg_1.id
  
}





