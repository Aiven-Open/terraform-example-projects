variable "aiven_token" {
  description = "Aiven token"
  type        = string
}

variable "datadog_api_key" {
  description = "Datadog API Key"
  sensitive   = true
  type        = string
}

variable "datadog_site" {
  description = "Datadog site for your account"
  type        = string
}
