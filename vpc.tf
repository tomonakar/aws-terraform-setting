#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc-A" {
    cidr_block                  = "${var.root_segment}"
    enable_dns_support          = "true"
    enable_dns_hostnames        = "true"
    tags {
        Name                    = "vpc-${var.app_name}"
    }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "A-igw" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    tags {
        Name                    = "${var.app_name}-igw"
    }
}

#####################################
# Public Subnets Settings
#####################################
resource "aws_subnet" "A_subnet_pub_001" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.A_subnet_pub_001}"
    availability_zone           = "${var.A_subnet_pub_001_az}"
    tags {
        Name                    = "A_subnet_pub_001"
    }
}
resource "aws_subnet" "B_subnet_pub_001" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.B_subnet_pub_001}"
    availability_zone           = "${var.B_subnet_pub_001_az}"
    tags {
        Name                    = "B_subnet_pub_001"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "A_subnet_pri_001" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.A_subnet_pri_001}"
    availability_zone           = "${var.A_subnet_pri_001_az}"
    tags {
        Name                    = "A_subnet_pri_001"
    }
}

resource "aws_subnet" "A_subnet_pri_002" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.A_subnet_pri_002}"
    availability_zone           = "${var.A_subnet_pri_002_az}"
    tags {
        Name                    = "A_subnet_pri_002"
    }
}

resource "aws_subnet" "B_subnet_pri_001" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.B_subnet_pri_001}"
    availability_zone           = "${var.B_subnet_pri_001_az}"
    tags {
        Name                    = "B_subnet_pri_001"
    }
}

resource "aws_subnet" "B_subnet_pri_002" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    cidr_block                  = "${var.B_subnet_pri_002}"
    availability_zone           = "${var.B_subnet_pri_002_az}"
    tags {
        Name                    = "B_subnet_pri_002"
    }
}


#####################################
# Nat Gateway  Settings
#####################################
resource "aws_eip" "A-nat" {
    vpc                         = true
}

resource "aws_eip" "B-nat" {
    vpc                         = true
}

resource "aws_nat_gateway" "A-nat" {
    allocation_id               = "${aws_eip.A-nat.id}"
    subnet_id                   = "${aws_subnet.A_subnet_pub_001.id}"
}

resource "aws_nat_gateway" "B-nat" {
    allocation_id               = "${aws_eip.B-nat.id}"
    subnet_id                   = "${aws_subnet.B_subnet_pub_001.id}"
}



#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "rtb-A-pub" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = "${aws_internet_gateway.A-igw.id}"
    }
    tags {
        Name                    = "rtb-A-pub"
    }
}

resource "aws_route_table" "rtb-B-pub" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = "${aws_internet_gateway.A-igw.id}"
    }
    tags {
        Name                    = "rtb-B-pub"
    }
}

resource "aws_route_table" "rtb-A-pri" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = "${aws_nat_gateway.A-nat.id}"
    }
    tags {
        Name                    = "rtb-A-pri"
    }
}

resource "aws_route_table" "rtb-B-pri" {
    vpc_id                      = "${aws_vpc.vpc-A.id}"
    route {
        cidr_block              = "0.0.0.0/0"
        gateway_id              = "${aws_nat_gateway.B-nat.id}"
    }
    tags {
        Name                    = "rtb-B-pri"
    }
}

resource "aws_route_table_association" "A-pub-association" {
    subnet_id                   = "${aws_subnet.A_subnet_pub_001.id}"
    route_table_id              = "${aws_route_table.rtb-A-pub.id}"
}

resource "aws_route_table_association" "B-pub-association" {
    subnet_id                   = "${aws_subnet.B_subnet_pub_001.id}"
    route_table_id              = "${aws_route_table.rtb-B-pub.id}"
}

resource "aws_route_table_association" "A-pri-association" {
    subnet_id                   = "${aws_subnet.A_subnet_pri_001.id}"
    route_table_id              = "${aws_route_table.rtb-A-pri.id}"
}

resource "aws_route_table_association" "B-pri-association" {
    subnet_id                   = "${aws_subnet.B_subnet_pri_001.id}"
    route_table_id              = "${aws_route_table.rtb-B-pri.id}"
}
