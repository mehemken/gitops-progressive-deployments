variable "vpc_id" { type = string }

variable "private_subnets" {
  type        = list(any)
  description = "The ids"
}

variable "public_subnets" {
  type        = list(any)
  description = "The ids"
}
