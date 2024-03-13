 module "remote_bucket-mod" {
    source = "./remote_pucket"
  
}


module "vpc_mod" {
  source = "./vpc"
}

 module "public_subnet_1_mod" {
  source = "./public_sub_1"
  vpc_id = module.vpc_mod.vpc_id
  #ig_id = module.ig.ig-id

}


module "public_subnet_2_mod" {
  source = "./public_sub_2"
  vpc_id = module.vpc_mod.vpc_id
  #ig_id = module.ig.ig-id
}


module "private_subnet_1" {
  source = "./private_sub_1"
  vpc_id = module.vpc_mod.vpc_id
}

module "private_subnet_2" {
  source = "./private_sub_2"
  vpc_id = module.vpc_mod.vpc_id
}


module "data_block" {
  source = "./data_block"
  vpc_id = module.vpc_mod.vpc_id
}


module "ec2_proxy_1" {
  source = "./ec2_proxy_1"
  vpc_security_group_ids = [module.data_block.sg_id]
  ami = module.data_block.ami_id
  subnet_id = module.public_subnet_1_mod.subnet_id
  dns_name = module.alb_http.elb-dns-name
} 

module "ec2_proxy_2" {
  source = "./ec2_proxy_2"
  ami_id = module.data_block.ami_id
  vpc_security_group_ids = [module.data_block.sg_id]
  subnet_id = module.public_subnet_2_mod.subnet_id
  dns_name = module.alb_http.elb-dns-name

  
}

module "ec2_apache_1" {
  source = "./ec2_apache_1"
  vpc_security_group_ids = [module.data_block.sg_id]
  ami = module.data_block.ami_id
  subnet_id = module.private_subnet_1.subnet_id
  
}


module "ec2_apache_2" {
  source = "./ec2_apache_2"
  vpc_security_group_ids = [module.data_block.sg_id]
  ami = module.data_block.ami_id
  subnet_id_2 = module.private_subnet_2.subnet_id
  
}


module "alb_http" {
  source = "./alb-http"
  vpc_id = module.vpc_mod.vpc_id
  vpc_security_group_ids = [module.data_block.sg_id]
  subnet_id = module.private_subnet_1.subnet_id
  subnet_id_2 = module.private_subnet_2.subnet_id
  apache_instance_id = module.ec2_apache_1.apache_instance_id
  apache_instance_id_2 = module.ec2_apache_2.apache_instance_2_id
    
  }
  

  module "ig" {
    source = "./ig" 
    vpc_id = module.vpc_mod.vpc_id  
    pub_sub_1_id = module.public_subnet_1_mod.subnet_id
    pub_sub_2_id = module.public_subnet_2_mod.subnet_id

  }


module "alb_nginx" {
 source = "./alb-proxy"  
 vpc_id = module.vpc_mod.vpc_id
 vpc_security_group_ids = [module.data_block.sg_id]
 subnet_id = module.public_subnet_1_mod.subnet_id
 subnet_id_2 = module.public_subnet_2_mod.subnet_id
 instance-id-1 = module.ec2_proxy_1.instance_id
 instance-id-2 = module.ec2_proxy_2.instance_id
}




