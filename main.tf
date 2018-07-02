# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

data "aws_region" "current" {}

locals {
  spot_fleet_tags = "${map("Name", "${var.name_prefix}-spot-instance")}"
}

resource "aws_iam_role" "spotfleet" {
  name               = "${var.name_prefix}-spotfleet"
  assume_role_policy = "${data.aws_iam_policy_document.spotfleet-assume.json}"
}

resource "aws_iam_policy_attachment" "spotfleet" {
  name       = "${var.name_prefix}-spotfleet"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
  roles      = ["${aws_iam_role.spotfleet.name}"]
}

data "aws_iam_policy_document" "spotfleet-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2-instance" {
  name               = "${var.name_prefix}-ec2-instances"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-instance-assume.json}"
}

data "aws_iam_policy_document" "ec2-instance-assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_security_group" "main" {
  name        = "${var.name_prefix}-sg"
  description = "Terraformed security group."
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", "${var.name_prefix}-sg"))}"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.main.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.name_prefix}-ec2-instance"
  role = "${aws_iam_role.ec2-instance.name}"
}
