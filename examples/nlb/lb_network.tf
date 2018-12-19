module "lb_network" {
  source = "../../"

  environment = "${var.environment}"
  project     = "${var.project}"
  name_suffix = "${var.project}"

  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"
  subnets  = "${module.vpc.public_subnets}"
  type     = "network"
  internal = false
}
