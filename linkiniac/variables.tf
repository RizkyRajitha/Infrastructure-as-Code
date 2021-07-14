variable "instance_name" {
  description = "name of the instance"
  type        = string
  default     = "iacdemoec2"
}

variable "az" {
  description = "az of the resources"
  type        = string
  default     = "us-east-1a"
}