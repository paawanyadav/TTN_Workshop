# Target Group

resource "aws_lb_target_group" "wordpress-tg" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

# Application Load balancer

resource "aws_lb" "wordpress-lb" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Security_TF.id]
  subnets            = [aws_subnet.public_subnet2.id, aws_subnet.public_subnet.id]

  tags = {
    Environment = "production"
  }
}

# Load Balancer Listener

resource "aws_lb_listener" "lb_tg_attach" {
  load_balancer_arn = aws_lb.wordpress-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}

# Template

resource "aws_launch_template" "wordpress-tmplt" {
  name = "wordpress"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 8
      delete_on_termination = true
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  image_id = var.ami

  instance_type = var.instance_type

  key_name = "LEMPAWS"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public_subnet.id
    security_groups             = [aws_security_group.Security_TF.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("./script/nginx_Script.sh")
}

#  Auto Scaling Group

resource "aws_autoscaling_group" "ASG" {
  name                      = "wordpress-asg"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.wordpress-tg.arn]
  vpc_zone_identifier       = [aws_subnet.public_subnet.id]
  launch_template {
    id = aws_launch_template.wordpress-tmplt.id
  }
}
