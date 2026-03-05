resource "aws_autoscaling_group" "this" {
  name = "${var.project_name}-asg"

  min_size = 2
  max_size = 6
  desired_capacity = 2

  vpc_zone_identifier = var.private_subnets

  health_check_type = "ELB"
  health_check_grace_period = 300

  target_group_arns = [var.target_group_arn]

  launch_template {
    id = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "${var.project_name}-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
