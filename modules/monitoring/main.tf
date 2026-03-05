resource "aws_autoscaling_policy" "scale_out" {
  name = "${var.project_name}-scale-out"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 120
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_in" {
  name = "${var.project_name}-scale-in"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 120
  autoscaling_group_name = var.asg_name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 60
  alarm_description = "Scale out if CPU > 60%"
  alarm_actions = [aws_autoscaling_policy.scale_out.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name = "${var.project_name}-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = 3
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 30
  alarm_description = "Scale in if CPU < 30%"
  alarm_actions = [aws_autoscaling_policy.scale_in.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}
