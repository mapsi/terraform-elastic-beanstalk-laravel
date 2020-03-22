region = "eu-west-2"

profile = "tf-test"

availability_zones = ["eu-west-2a", "eu-west-2b"]

namespace = "eg"

stage = "test"

name = "elastic-beanstalk-env"

description = "Test elastic-beanstalk-environment"

tier = "WebServer"

environment_type = "LoadBalanced"

loadbalancer_type = "application"

availability_zone_selector = "Any 2"

instance_type = "t3.micro"

managed_actions_enabled = true

preferred_start_time = "Sun:10:00"

update_level = "minor"

instance_refresh_enabled = true

autoscale_min = 1

autoscale_max = 4

wait_for_ready_timeout = "20m"

force_destroy = true

rolling_update_enabled = true

rolling_update_type = "Immutable"

updating_min_in_service = 2

updating_max_batch = 1

healthcheck_url = "/"

application_port = 80

root_volume_size = 8

root_volume_type = "gp2"

autoscale_measure_name = "CPUUtilization"

autoscale_statistic = "Average"

autoscale_unit = "Percent"

autoscale_lower_bound = 20

autoscale_lower_increment = -1

autoscale_upper_bound = 80

autoscale_upper_increment = 1

elb_scheme = "public"

// https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
// https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
solution_stack_name = "64bit Amazon Linux 2018.03 v2.9.3 running PHP 7.2"

version_label = ""

dns_zone_id = "Z09672541EASXB7W9KWNF"

// https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html
additional_settings = [
  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "false"
  },
  {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "false"
  }
]

env_vars = {
  "DB_HOST"         = "xxxxxxxxxxxxxx"
  "DB_USERNAME"     = "yyyyyyyyyyyyy"
  "DB_PASSWORD"     = "zzzzzzzzzzzzzzzzzzz"
  "ANOTHER_ENV_VAR" = "123456789"
}
