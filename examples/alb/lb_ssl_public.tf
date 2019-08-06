locals {
  lb_ssl_public_dns_name   = var.dns_name
  lb_ssl_public_dns_prefix = "forest-lb-ssl-public"
}

data "aws_route53_zone" "selected" {
  name = "${local.lb_ssl_public_dns_name}."
}

data "aws_acm_certificate" "certificate" {
  domain = "*.${substr(
    data.aws_route53_zone.selected.name,
    0,
    length(data.aws_route53_zone.selected.name) - 1,
  )}"
  statuses = ["ISSUED"]
}

module "lb_ssl_public" {
  source      = "../../"
  name_prefix = "ssl-"

  environment = var.environment
  project     = var.project
  name_suffix = var.project

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  subnets  = module.vpc.public_subnets
  type     = "application"
  internal = false

  certificate_arn = data.aws_acm_certificate.certificate.arn
  dns_name        = "${local.lb_ssl_public_dns_prefix}.${local.lb_ssl_public_dns_name}"
  dns_zone_id     = data.aws_route53_zone.selected.zone_id
  port            = 443
}

output "lb_ssl_public_dns" {
  description = "DNS - ssl public dns"
  value       = "https://${local.lb_ssl_public_dns_prefix}.${local.lb_ssl_public_dns_name}"
}

