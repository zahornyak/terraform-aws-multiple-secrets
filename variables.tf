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

variable "unlocked" {
  description = "if true - sets the ignore lifecycle policy and disable terraform managing the version of the resource"
  type        = bool
  default     = false
}