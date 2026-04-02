  GNU nano 8.7                                                                       asg.tf                                                                       Modified


















resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 2

  vpc_zone_identifier = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  health_check_type = "ELB"
}

