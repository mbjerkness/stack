/**
 * This module is used to set configuration defaults for the AWS infrastructure.
 * It doesn't provide much value when used on its own because terraform makes it
 * hard to do dynamic generations of things like subnets, for now it's used as
 * a helper module for the stack.
 *
 * Usage:
 *
 *     module "defaults" {
 *       source = "github.com/segmentio/stack/defaults"
 *       region = "us-east-1"
 *       cidr   = "10.0.0.0/16"
 *     }
 *
 */

variable "region" {
  description = "The AWS region"
}

variable "cidr" {
  description = "The CIDR block to provision for the VPC"
}

# Want to use new ones...but alas.
# Need to figure out how to build a new AMI with the updated ECS agent with packer
# Could also figure out how to use the Amazon ECS Optimized AMI, but need to figure out logging...
variable "default_ecs_ami" {
  default = {
    us-east-1      = "ami-275ffe31"
    us-west-1      = "ami-689bc208"
    us-west-2      = "ami-62d35c02"
    eu-west-1      = "ami-95f8d2f3"
    eu-central-1   = "ami-085e8a67"
    ap-northeast-1 = "ami-f63f6f91"
    ap-northeast-2 = "ami-8a4b9ce4"
    ap-southeast-1 = "ami-b4ae1dd7"
    ap-southeast-2 = "ami-fbe9eb98"
    sa-east-1      = "ami-29039a45"
  }
}

# http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-access-logs.html#attach-bucket-policy
variable "default_log_account_ids" {
  default = {
    us-east-1      = "127311923021"
    us-west-2      = "797873946194"
    us-west-1      = "027434742980"
    eu-west-1      = "156460612806"
    eu-central-1   = "054676820928"
    ap-southeast-1 = "114774131450"
    ap-northeast-1 = "582318560864"
    ap-southeast-2 = "783225319266"
    ap-northeast-2 = "600734575887"
    sa-east-1      = "507241528517"
    us-gov-west-1  = "048591011584"
    cn-north-1     = "638102146993"
  }
}

output "domain_name_servers" {
  value = "${cidrhost(var.cidr, 2)}"
}

output "ecs_ami" {
  value = "${lookup(var.default_ecs_ami, var.region)}"
}

output "s3_logs_account_id" {
  value = "${lookup(var.default_log_account_ids, var.region)}"
}
