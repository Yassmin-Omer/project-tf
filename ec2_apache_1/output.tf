output "apache_instance_id" {
 value =  aws_instance.apache_instance.id
}

output "private_ip" {
    value = aws_instance.apache_instance.private_ip
  
}