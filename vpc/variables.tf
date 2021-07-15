variable "private_instance_name" {
  description = "name of the instance"
  type        = string
  default     = "iacdemoec2private"
}

variable "public_instance_name" {
  description = "name of the instance"
  type        = string
  default     = "iacdemoec2public"
}

variable "region" {
  description = "region of the resources"
  type        = string
  default     = "us-east-1"
}


