
output "vpc" {
    value = module.vpc_mod.vpc_id
  
}

output "pub_sub_1" {
  value = module.public_subnet_1_mod.subnet_id
} 


output "pub_sub_2" {
  value = module.public_subnet_2_mod.subnet_id
} 

output "sg" {
  value=module.data_block.sg_id
  
}


output "ami_id" {
  value = module.data_block.ami_id
  
}

output "pub_sub_1_id" {
  value = module.public_subnet_1_mod.subnet_id
  
}

output "private_sub_1" {
  value = module.private_subnet_1.subnet_id

}


output "private_sub_2" {
  value = module.private_subnet_2.subnet_id
  
}


output "apache_instance_1" {
  value = module.ec2_apache_1.apache_instance_id
  
}

output "apache_instance_2" {
  value = module.private_subnet_2.subnet_id
  
}


output "private_ip_http1" {
  value = module.ec2_apache_1.private_ip
  
}


output "private_ip_http2" {
  value = module.ec2_apache_2.private_ip
  
}

output "lb_http_dns" {
value =  module.alb_http.elb-dns-name
}



output "ig" {
  value = module.ig.ig-id  
}


output "proxy_1_id" {
  value = module.ec2_proxy_1.instance_id
}

output "proxy_2_id" {
  value = module.ec2_proxy_2.instance_id
}

/* output "pub_sub_1" {
 value = module.public_subnet_1_mod.subnet_id  
}

output "pub_sub_2" {
 value = module.public_subnet_2_mod.subnet_id
} */


