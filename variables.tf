variable "environment" {
  description = "Name of the environment (e.g. project-dev); will be prefixed to all resources."
  type        = string
}

variable "project" {
  description = "Project cost center / cost allocation."
  type        = string
}

variable "protocol" {
  description = "Defines the ALB protocol to be used."
  type        = string
  default     = ""
}

variable "port" {
  description = "The port for the listenere and ingress traffic, only applies for type `application`."
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "The AWS certificate ARN, required for an ALB via HTTPS. The certificate should be available in the same zone."
  type        = string
  default     = ""
}

variable "timeout" {
  description = "The idle timeout in seconds of the ALB"
  type        = number
  default     = 60
}

variable "dns_name" {
  description = "The DNS name to connect to the load balancer if."
  type        = string
  default     = ""
}

variable "dns_zone_id" {
  description = "The DNS zone id of the DNS."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC to launch the LB, e.g. needed for the security group and target group."
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block which will be applied to the sceurity group of the LB. In case the LB is marked as exteral the ingress rule allows traffic from anywhere."
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnets to launch the LB."
  type        = list(string)
}

variable "internal" {
  description = "If true this ALB is only available within the VPC, default (true) is publicly accessable (internetfacing)."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "ssl_policy" {
  description = "SSL policy applied to an SSL enabled LB, see https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html. Will only be applied for the type `application` and protocol `HTTPS`"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "create_listener" {
  description = "True to create a listener resource. Only for type `application`"
  type        = bool
  default     = true
}

variable "type" {
  description = "Indication the type of a load balancer, possible values are: `application` and `network`."
  type        = string
  default     = "application"
}

variable "name_prefix" {
  description = "Prefix for load balancer name, "
  type        = string
  default     = "lb-tf-"
}

variable "name_suffix" {
  description = "Suffix which will be added to the name of resources and part of the tag `name`."
  type        = string
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled"
  type        = bool
  default     = false
}

