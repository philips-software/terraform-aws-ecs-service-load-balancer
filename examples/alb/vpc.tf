module "vpc" {
  source  = "philips-software/vpc/aws"
  version = "1.2.0"

  environment = "${var.environment}"
  aws_region  = "${var.aws_region}"
}
