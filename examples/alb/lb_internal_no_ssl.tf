module "lb_internal_no_ssl" {
  source      = "../../"
  name_prefix = "intern-"

  environment = var.environment
  project     = var.project
  name_suffix = var.project

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  subnets  = module.vpc.private_subnets
  type     = "application"

  port = 80
}

