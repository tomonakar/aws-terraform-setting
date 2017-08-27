#######################################
# TerraForm Variable Settings
#######################################
#AWS Setting
access_key   = ""
secret_key   = ""
region       = "ap-northeast-1"

#AppName
app_name     = ""

#Segment Settings
root_segment       = "10.0.0.0/16"
A_subnet_pub_001   = "10.0.1.0/24"
A_subnet_pri_001   = "10.0.10.0/24"
A_subnet_pri_002   = "10.0.11.0/24"
B_subnet_pub_001   = "10.0.2.0/24"
B_subnet_pri_001   = "10.0.20.0/24"
B_subnet_pri_002   = "10.0.21.0/24"

#AZ Settings
A_subnet_pub_001_az  = "ap-northeast-1c"
A_subnet_pri_001_az  = "ap-northeast-1c"
A_subnet_pri_002_az  = "ap-northeast-1a"
B_subnet_pub_001_az  = "ap-northeast-1c"
B_subnet_pri_001_az  = "ap-northeast-1c"
B_subnet_pri_002_az  = "ap-northeast-1a"

#KeyPair Settings
A_public_key    = "A-key"
B_public_key    = "B-key"

#AMI
rhel_ami           = "ami-5c9a933b"
win_ami            = "ami-249fad43"
amazonlinux_ami    = "ami-3bd3c45c"

#EC2 Instance_type
ec2_instance       = "m4.xlarge"

#EC2 B-mn01 Instance_type
B-mn01_instance    = "t2.medium"

#RDS Instance type
rds_instance       = "m4.2xlarge"

#KeyName
A_key  = "A-key"
B_key  = "B-key"
