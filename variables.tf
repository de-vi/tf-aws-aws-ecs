variable "name" {
  type = string
}

variable "alb_target_group_arn" {}
variable "container_definitions" {}
variable "container_name" {}
variable "container_port" {}
variable "desired_task_count" {}
