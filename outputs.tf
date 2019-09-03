output "arn" {
  value = local.arn
}

output "listener_arn" {
  value = element(concat(aws_lb_listener.listener.*.arn, [""]), 0)
}

output "lb_dns_name" {
  value = var.type == "application" ? element(concat(aws_lb.application.*.dns_name, [""]), 0) : element(concat(aws_lb.network.*.dns_name, [""]), 0)
}

