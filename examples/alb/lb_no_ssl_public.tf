module "lb_no_ssl_public" {
  source      = "../../"
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

data "aws_lb" "lb_no_ssl_public" {
  arn = module.lb_no_ssl_public.arn
}

output "lb_no_ssl_public_dns" {
  description = "DNS - lb_no_ssl_public"
  value       = "http://${data.aws_lb.lb_no_ssl_public.dns_name}"
}

