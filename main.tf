locals {
  arn              = "${var.type == "application" ? element(concat(aws_lb.application.*.arn, list("")), 0) : element(concat(aws_lb.network.*.arn, list("")), 0)}"
  nlb_protocol     = "${var.type == "network" && var.protocol == "" ? "TCP" : var.protocol}"
  alb_protocol     = "${var.type == "application" && var.protocol == "" ? "HTTP" : var.protocol}"
  alb_ssl_protocol = "${var.type == "application" && var.certificate_arn != "" && var.protocol == "" ? "HTTPS" : local.alb_protocol}"
  protocol         = "${var.type == "application" ? local.alb_ssl_protocol : local.nlb_protocol}"

  lb_name_prefix = "${length(var.name_prefix) > 6 ? replace(var.name_prefix, "/(.{0,6})(.*)/", "$1") : var.name_prefix}"
}

resource "aws_security_group" "security_group_lb" {
  count = "${var.type == "application" ? 1 : 0}"

  name_prefix = "${var.environment}-${var.name_suffix}"
  vpc_id      = "${var.vpc_id}"

  # allow all incoming traffic
  ingress = {
    from_port   = "${var.port}"
    to_port     = "${var.port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.internal ? var.vpc_cidr : "0.0.0.0/0"}"]
  }

  # allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  tags = "${merge(map("Name", format("%s", "${var.environment}-${var.name_suffix}")),
            map("Environment", format("%s", var.environment)),
            map("Project", format("%s", var.project)),
            var.tags)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "application" {
  count = "${var.type == "application" ? 1 : 0}"

  name_prefix     = "${local.lb_name_prefix}"
  security_groups = ["${aws_security_group.security_group_lb.id}"]

  load_balancer_type = "${var.type}"
  internal           = "${var.internal}"

  subnets = ["${var.subnets}"]

  idle_timeout = "${var.timeout}"

  tags = "${merge(map("Name", format("%s", "${var.environment}-${var.name_suffix}")),
            map("Environment", format("%s", var.environment)),
            map("Project", format("%s", var.project)),
            var.tags)}"
}

resource "aws_lb" "network" {
  count = "${var.type == "network" ? 1 : 0}"

  name_prefix        = "${local.lb_name_prefix}"
  load_balancer_type = "${var.type}"
  internal           = "${var.internal}"

  subnets = ["${var.subnets}"]

  idle_timeout = "${var.timeout}"

  tags = "${merge(map("Name", format("%s", "${var.environment}-${var.name_suffix}")),
            map("Environment", format("%s", var.environment)),
            map("Project", format("%s", var.project)),
            var.tags)}"
}

resource "aws_lb_listener" "listener" {
  count      = "${var.create_listener && var.type == "application" ? 1 : 0}"
  depends_on = ["aws_lb.application"]

  load_balancer_arn = "${local.arn}"
  protocol          = "${local.protocol}"
  port              = "${var.port}"
  certificate_arn   = "${var.certificate_arn}"
  ssl_policy        = "${local.protocol == "HTTPS" ? "${var.ssl_policy}": ""}"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

data "aws_lb" "lb" {
  arn = "${local.arn}"
}

resource "aws_route53_record" "dns_record" {
  count = "${var.dns_name != "" && var.dns_zone_id != "" ? 1 : 0}"

  name    = "${var.dns_name}"
  zone_id = "${var.dns_zone_id}"
  type    = "A"

  alias {
    name                   = "${data.aws_lb.lb.dns_name}"
    zone_id                = "${data.aws_lb.lb.zone_id}"
    evaluate_target_health = true
  }
}
