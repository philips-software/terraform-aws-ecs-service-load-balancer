output "arn" {
  value = "${local.arn}"
}

output "listener_arn" {
  value = "${element(concat(aws_lb_listener.listener.*.arn, list("")), 0)}"
}
