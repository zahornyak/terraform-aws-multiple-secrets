variable "secrets" {
  description = "Map of secrets to keep in AWS Secrets Manager"
  type        = any
  default     = {}
}

variable "recovery_window_in_days" {
  description = "Specifies the number of days for recovery window"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Specifies a tags"
  type        = any
  default     = {}
}

variable "unmanaged" {
  description = "Terraform must ignore secrets lifecycle. Using this option you can initialize the secrets and rotate them outside Terraform, thus, avoiding other users to change or rotate the secrets by subsequent runs of Terraform"
  type        = bool
  default     = false
}