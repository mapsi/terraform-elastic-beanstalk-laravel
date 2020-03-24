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

instance_type_ec2 = "t3.micro"

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
solution_stack_name = "64bit Amazon Linux 2018.03 v2.9.3 running PHP 7.3"

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


### DB ###

deletion_protection = false

database_name = "test_db"

database_user = "admin"

database_password = "admin_password"

database_port = 3306

multi_az = false

storage_type = "standard"

storage_encrypted = false

allocated_storage = 5

engine = "mysql"

engine_version = "5.7.17"

major_engine_version = "5.7"

instance_class = "db.t2.small"

db_parameter_group = "mysql5.7"

publicly_accessible = false

apply_immediately = true


## REDIS ##

instance_type_redis = "cache.t2.micro"

cluster_size = 1

family = "redis4.0"

engine_version_redis = "4.0.10"

at_rest_encryption_enabled = false

transit_encryption_enabled = true

zone_id = "Z3SO0TKDDQ0RGG"