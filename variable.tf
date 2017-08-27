#####################################
# Variable Settings
#####################################
#AWS Settings
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

#App Name
variable "app_name" {}

#Segument Settings
variable "root_segment" {}
variable "A_subnet_pub_001" {}
variable "A_subnet_pri_001" {}
variable "A_subnet_pri_002" {}
variable "B_subnet_pub_001" {}
variable "B_subnet_pri_001" {}
variable "B_subnet_pri_002" {}

#AZ Settings
variable "A_subnet_pub_001_az" {}
variable "A_subnet_pri_001_az" {}
variable "A_subnet_pri_002_az" {}
variable "B_subnet_pub_001_az" {}
variable "B_subnet_pri_001_az" {}
variable "B_subnet_pri_002_az" {}

#KeyPair Settings
variable "A_public_key" {}
variable "B_public_key" {}


#AMI
variable "rhel_ami" {}
variable "win_ami" {}
variable "amazonlinux_ami" {}

#Instance
variable "ec2_instance" {}
variable "B-mn01_instance" {}
variable "rds_instance" {}

##EC2 Name
variable "A-ec2-name" {
    default = {
        "0" = "A-ap01"
        "1" = "A-ap02"
        "2" = "A-fm01"
        "3" = "A-fm02"
        "4" = "A-ml01"
        "5" = "A-ml01"
        "6" = "A-ns01"
 }
}

variable "B-ec2-name" {
    default = {
        "0" = "B-ap01"
        "1" = "B-ap02"
        "2" = "B-ns01"
 }
}

variable "A-pri-ip" {
    default = {
        "0" = "10.0.10.4"
        "1" = "10.0.10.5"
        "2" = "10.0.10.6"
        "3" = "10.0.10.7"
        "4" = "10.0.10.8"
        "5" = "10.0.10.9"
        "6" = "10.0.10.10"
 }
}

variable "B-pri-ip" {
    default = {
        "0" = "10.0.20.4"
        "1" = "10.0.20.5"
        "2" = "10.0.20.6"
 }
}


#Key Name
variable "A_key" {}
variable "B_key" {}
