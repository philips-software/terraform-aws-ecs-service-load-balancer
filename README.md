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
  source      = "git::https://github.com/philips-software/terraform-aws-ecs-service-load-balancer.git"
  
  name_prefix = "public-"
  

  environment = var.environment
  project     = var.project
  name_suffix = var.project

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  subnets  = module.vpc.public_subnets
  type     = "application"
  internal = false

  port = 80
}
```

## Network Load Balancer


### Example usages:
```
module "lb_network" {
  source = "git::https://github.com/philips-software/terraform-aws-ecs-service-load-balancer.git"

  environment = var.environment
  project     = var.project
  name_suffix = var.project

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  subnets  = module.vpc.public_subnets
  type     = "network"
  internal = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate\_arn | The AWS certificate ARN, required for an ALB via HTTPS. The certificate should be available in the same zone. | string | `""` | no |
| create\_listener | True to create a listener resource. Only for type `application` | bool | `"true"` | no |
| dns\_name | The DNS name to connect to the load balancer if. | string | `""` | no |
| dns\_zone\_id | The DNS zone id of the DNS. | string | `""` | no |
| enable\_cross\_zone\_load\_balancing | If true, cross-zone load balancing of the load balancer will be enabled | bool | `"false"` | no |
| environment | Name of the environment (e.g. project-dev); will be prefixed to all resources. | string | n/a | yes |
| internal | If true this ALB is only available within the VPC, default (true) is publicly accessable (internetfacing). | bool | `"true"` | no |
| name\_prefix | Prefix for load balancer name, | string | `"lb-tf-"` | no |
| name\_suffix | Suffix which will be added to the name of resources and part of the tag `name`. | string | n/a | yes |
| port | The port for the listenere and ingress traffic, only applies for type `application`. | string | `""` | no |
| project | Project cost center / cost allocation. | string | n/a | yes |
| protocol | Defines the ALB protocol to be used. | string | `""` | no |
| ssl\_policy | SSL policy applied to an SSL enabled LB, see https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html. Will only be applied for the type `application` and protocol `HTTPS` | string | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| subnets | List of subnets to launch the LB. | list(string) | n/a | yes |
| tags | A map of tags to add to the resources | map(string) | `<map>` | no |
| timeout | The idle timeout in seconds of the ALB | number | `"60"` | no |
| type | Indication the type of a load balancer, possible values are: `application` and `network`. | string | `"application"` | no |
| vpc\_cidr | CIDR block which will be applied to the sceurity group of the LB. In case the LB is marked as exteral the ingress rule allows traffic from anywhere. | string | `""` | no |
| vpc\_id | The VPC to launch the LB, e.g. needed for the security group and target group. | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| lb\_dns\_name |  |
| listener\_arn |  |

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
