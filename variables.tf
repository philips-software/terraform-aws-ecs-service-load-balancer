variable "environment" {
  description = "Name of the environment (e.g. project-dev); will be prefixed to all resources."
  type        = "string"
}

variable "project" {
  description = "Project cost center / cost allocation."
  type        = "string"
}

variable "protocol" {
  type        = "string"
  description = "Defines the ALB protocol to be used."
  default     = ""
}

variable "port" {
  type        = "string"
  description = "The port for the listenere and ingress traffic, only applies for type `application`."
  default     = ""
}

variable "certificate_arn" {
  description = "The AWS certificate ARN, required for an ALB via HTTPS. The certificate should be available in the same zone."
  type        = "string"
  default     = ""
}

variable "timeout" {
  description = "The idle timeout in seconds of the ALB"
  default     = 60
}

variable "dns_name" {
  type        = "string"
  description = "The DNS name to connect to the load balancer if."
  default     = ""
}

variable "dns_zone_id" {
  type        = "string"
  description = "The DNS zone id of the DNS."
  default     = ""
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC to launch the LB, e.g. needed for the security group and target group."
  default     = ""
}

variable "vpc_cidr" {
  type        = "string"
  description = "CIDR block which will be applied to the sceurity group of the LB. In case the LB is marked as exteral the ingress rule allows traffic from anywhere."
  default     = ""
}

variable "subnets" {
  type        = "list"
  description = "List of subnets to launch the LB."
}

variable "internal" {
  description = "If true this ALB is only available within the VPC, default (true) is publicly accessable (internetfacing)."
  default     = true
}

variable "tags" {
  type        = "map"
  description = "A map of tags to add to the resources"
  default     = {}
}

variable "ssl_policy" {
  type        = "string"
  description = "SSL policy applied to an SSL enabled LB, see https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html. Will only be applied for the type `application` and protocol `HTTPS`"
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "create_listener" {
  description = "True to create a listener resource. Only for type `application`"
  default     = true
}

variable "type" {
  type        = "string"
  description = "Indication the type of a load balancer, possible values are: `application` and `network`."
  default     = "application"
}

variable "name_prefix" {
  type        = "string"
  description = "Prefix for load balancer name, "
  default     = "lb-tf-"
}

variable "name_suffix" {
  type        = "string"
  description = "Suffix which will be added to the name of resources and part of the tag `name`."
}

variable "enable_cross_zone_load_balancing" {
  default     = false
  description = "If true, cross-zone load balancing of the load balancer will be enabled"
}
