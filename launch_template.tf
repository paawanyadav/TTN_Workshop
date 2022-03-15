provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_lb_target_group" "wordpress-tg" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0567fdd08e89a59b4"
}

resource "aws_lb" "wordpress-lb" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-043c3e7d7669e88d8"]
  subnets            = ["subnet-002eb8ae9cfb74bb2"]

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "lb_tg_attach" {
  load_balancer_arn = aws_lb.wordpress-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}

resource "aws_launch_template" "wordpress-tmplt" {
  name = "wordpress"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
      delete_on_termination = true
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  image_id = "ami-0851b76e8b1bce90b"

  instance_type = "t2.micro"

  key_name = "shreyansh2"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = "subnet-002eb8ae9cfb74bb2"
    security_groups = ["sg-043c3e7d7669e88d8"]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = file("/home/shreyansh/bootcamp/Assignments/terraform/workshop/workshop.sh")
}


resource "aws_autoscaling_group" "ASG" {
  name                      = "wordpress-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  target_group_arns         = [aws_lb.wordpress-lb.arn]
  vpc_zone_identifier       = ["subnet-002eb8ae9cfb74bb2"]
  launch_template {
    id      = aws_launch_template.wordpress-tmplt.d
  }
}