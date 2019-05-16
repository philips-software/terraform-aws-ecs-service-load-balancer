# Terraform module for creating Load Balancers for ECS services

Terraform module creates resources to load balance a ECS service, optional a listener and DNS recored can be created.


## Applicaton Load Balancers

The following scenario's are supported for creating a Load Balancer of type `application`
- Internal vs External
- SSL (HTTPS) vs HTTP
- Disable the creation of a listener
The default listener will return a fix response for traffic to `/` with a `404 - Not Found`.

### Example usages:
```
module "lb_no_ssl_public" {
  source = "philips-software/ecs-service-load-balancer/aws"

  environment = "my-env"
  project     = "my-project"
  name_suffix = "app"

  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"
  subnets  = "${module.vpc.public_subnets}"
  type     = "application"
  internal = false
}
```

## Network Load Balancer


### Example usages:
```

module "lb_network" {
  source = "philips-software/ecs-service-load-balancer/aws"

  environment = "my-env"
  project     = "my-project"
  name_suffix = "net"

  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"
  subnets  = "${module.vpc.public_subnets}"
  type     = "network"

  internal = true
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate_arn | The AWS certificate ARN, required for an ALB via HTTPS. The certificate should be available in the same zone. | string | `` | no |
| create_listener | True to create a listener resource. Only for type `application` | string | `true` | no |
| dns_name | The DNS name to connect to the load balancer if. | string | `` | no |
| dns_zone_id | The DNS zone id of the DNS. | string | `` | no |
| environment | Name of the environment (e.g. project-dev); will be prefixed to all resources. | string | - | yes |
| internal | If true this ALB is only available within the VPC, default (true) is publicly accessable (internetfacing). | string | `true` | no |
| name_prefix | Prefix for load balancer name, | string | `lb-tf-` | no |
| name_suffix | Suffix which will be added to the name of resources and part of the tag `name`. | string | - | yes |
| port | The port for the listenere and ingress traffic, only applies for type `application`. | string | `` | no |
| project | Project cost center / cost allocation. | string | - | yes |
| protocol | Defines the ALB protocol to be used. | string | `` | no |
| ssl_policy | SSL policy applied to an SSL enabled LB, see https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html. Will only be applied for the type `application` and protocol `HTTPS` | string | `ELBSecurityPolicy-TLS-1-2-2017-01` | no |
| subnets | List of subnets to launch the LB. | list | - | yes |
| tags | A map of tags to add to the resources | map | `<map>` | no |
| timeout | The idle timeout in seconds of the ALB | string | `60` | no |
| type | Indication the type of a load balancer, possible values are: `application` and `network`. | string | `application` | no |
| vpc_cidr | CIDR block which will be applied to the sceurity group of the LB. In case the LB is marked as exteral the ingress rule allows traffic from anywhere. | string | `` | no |
| vpc_id | The VPC to launch the LB, e.g. needed for the security group and target group. | string | `` | no |
| enable_cross_zone_load_balancing | Enable cross zone load balancing. | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| listener_arn |  |
| lb_dns_name | DNS of Load Balancer |

## Philips Forest

This module is part of the Philips Forest.

```
                                                     ___                   _
                                                    / __\__  _ __ ___  ___| |_
                                                   / _\/ _ \| '__/ _ \/ __| __|
                                                  / / | (_) | | |  __/\__ \ |_
                                                  \/   \___/|_|  \___||___/\__|  

                                                                 Infrastructure
```

Talk to the forestkeepers in the `forest`-channel on Slack.

[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)
