#####################################
# Placement Group
#####################################
## Placement group Setting
resource "aws_placement_group" "A_pg" {
    name                        = "A_pg"
    strategy                    = "cluster"
}

resource "aws_placement_group" "B_pg" {
    name                        = "B_pg"
    strategy                    = "cluster"
}



#####################################
# EC2 Setting
#####################################
## B EC2 Setting
resource "aws_instance" "B-ec2-instance" {
    count                       = 3
    ami                         = "${var.rhel_ami}"
    instance_type               = "${var.ec2_instance}"
    availability_zone           = "${var.B_subnet_pri_001_az}"
    disable_api_termination     = true
    ebs_optimized               = true
    monitoring                  = false
    private_ip                  = "${lookup(var.B-pri-ip,count.index)}"
    vpc_security_group_ids      = ["${aws_security_group.sg_A_construction.id}"]
    subnet_id                   = "${aws_subnet.B_subnet_pri_001.id}"
    associate_public_ip_address = false
    placement_group             = "${aws_placement_group.B_pg.name}"
    key_name                    = "${var.B_public_key}"
    tags {
        Name = "${lookup(var.B-ec2-name,count.index)}"
    }

    volume_tags{
        Name = "${lookup(var.B-ec2-name,count.index)}"
    }

    root_block_device {
        delete_on_termination = 0
	volume_size           = 100
	volume_type           = "gp2"
    }
}


