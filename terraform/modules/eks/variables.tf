variable "vpc_id" { type = string }

variable "private_subnets" {
  type        = list(any)
  description = "The ids"
  default     = []
}

variable "public_subnets" {
  type        = list(any)
  description = "The ids"
  default     = []
}
