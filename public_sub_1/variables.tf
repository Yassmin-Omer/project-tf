variable "cidr_public_subnet_1" {
    default = "10.0.0.0/24"
}

variable "sub_name_1" {
    default = "public-subnet-1" 
    
}

/*  variable "ig_id" {

}  */

variable "route_table" {
    default = "0.0.0.0/0"
  
}


variable "route_table_name" {
    default = "public-route-table-1" 
}


variable "vpc_id" {
}

