#####################################
# ELB
#####################################
## 本番外部ELB
resource "aws_elb" "lb-out-A" {
    name = "lb-out-A"
    availability_zones = ["${var.A_subnet_pub_001_az}"]
    security_groups    = ["${aws_security_group.sg_A_elb.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

 # listener {
 #   instance_port     = 80
 #   instance_protocol = "http"
 #   lb_port           = 443
 #   lb_protocol       = "https"
 #   ssl_certificate_id =""
 # }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target 		= "HTTP:80/index.html"
    interval            = 30
  }
}

resource "aws_lb_cookie_stickiness_policy" "lb-out-A-policy" {
  name                     = "lb-out-A-policy"
  load_balancer            = "${aws_elb.lb-out-A.id}"
  lb_port                  = 80
  cookie_expiration_period = ""


# 検証外部ELB
resource "aws_elb" "lb-out-B" {
    name = "lb-out-B"
    security_groups    = ["${aws_security_group.sg_A_elb.id}"]
    availability_zones = ["${var.B_subnet_pri_001_az}"]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#  listener {
#    instance_port     = 80
#    instance_protocol = "http"
#    lb_port           = 443
#    lb_protocol       = "https"
#    ssl_certificate_id =""
#  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 30
  }

 instances = ["${aws_instance.B-ec2-instance.0.id}"]
 cross_zone_load_balancing = true

}



resource "aws_lb_cookie_stickiness_policy" "lb-out-B-policy" {
  name                     = "lb-out-B-policy"
  load_balancer            = "${aws_elb.lb-out-B.id}"
  lb_port                  = 80
  cookie_expiration_period = ""
}
