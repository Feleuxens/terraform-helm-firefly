variable "domain" {
  description = "Domain name"
  type        = string
}

variable "firefly_app_key" {
  description = "Firefly App Key"
  type = string
}

variable "cpu_request" {
  type = string
  default = "10m"
}

variable "memory_request" {
  type = string
  default = "256Mi"
}

variable "memory_limit" {
  type = string
  default = "512Mi"
}