# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "instance_ami" {
  description = "The EC2 image ID to launch."
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
}

variable "subnet_ids" {
  description = "ID of subnets where instances can be provisioned."
  type        = "list"
}

variable "vpc_id" {
  description = "The VPC ID."
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "allocation_strategy" {
  description = "Allocation stragegy either lowestPrice or diversified"
  default     = "lowestPrice"
}

variable "pre_defined_spotrequest" {
  description = "Which pre defined spot request list to use: small, small-ipv6, medium, medium-ipv6, large, large-ipv6"
  default     = "small"
}

variable "spot_price" {
  description = "The maximum price per unit (vCPU) - default is set to roughly on demand price"
  default     = "0.05"
}

variable "target_capacity" {
  description = "The target capacity of the request - in vCPUs"
  default     = "1"
}

variable "user_data" {
  description = "User data script for the launch configuration."
  default     = ""
}

variable "valid_until" {
  description = "Valid to date for the spot requests - after this date instances will not be replaced"
  default     = "2028-05-03T00:00:00Z"
}
