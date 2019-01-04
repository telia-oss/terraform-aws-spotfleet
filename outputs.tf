# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "role_id" {
  value = "${aws_iam_role.ec2-instance.id}"
}

output "role_arn" {
  value = "${aws_iam_role.ec2-instance.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.main.id}"
}

output "request_id" {
  description = "The request id of the spotfleet"
  value       = "${join(",",coalescelist(aws_spot_fleet_request.small.*.id,aws_spot_fleet_request.small-ipv6.*.id,aws_spot_fleet_request.medium.*.id,aws_spot_fleet_request.medium-ipv6.*.id,aws_spot_fleet_request.large.*.id,aws_spot_fleet_request.large-ipv6.*.id))}"
}

