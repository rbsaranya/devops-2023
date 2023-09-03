resource "aws_launch_configuration" "aws_autoscale_conf" {
name          = "server_config"
image_id      = "ami-051f7e7f6c2f40dc1"
instance_type = "t2.micro"
key_name      = "tf-key-pair"
}

resource "aws_autoscaling_group" "mygroup" {
name                      = "autoscalegroup"
max_size                  = 2
min_size                  = 1
health_check_grace_period = 30
health_check_type         = "EC2"
force_delete              = true
launch_configuration      = aws_launch_configuration.aws_autoscale_conf.name
  vpc_zone_identifier       = [aws_subnet.my_subnet.id]
}

resource "aws_autoscaling_schedule" "mygroup_schedule" {
scheduled_action_name  = "autoscalegroup_action"
min_size               = 1
max_size               = 2
desired_capacity       = 1
start_time             = "2023-09-03T10:36:00Z"
autoscaling_group_name = aws_autoscaling_group.mygroup.name
}

resource "aws_autoscaling_policy" "mygroup_policy" {
name                   = "autoscalegroup_policy"
scaling_adjustment     = 2
adjustment_type        = "ChangeInCapacity"
cooldown               = 60
autoscaling_group_name = aws_autoscaling_group.mygroup.name
}
