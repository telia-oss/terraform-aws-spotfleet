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
