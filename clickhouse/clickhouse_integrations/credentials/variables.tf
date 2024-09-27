variable "aiven_api_token" {
  description = "Aiven API token"
  type        = string
  sensitive = true
}

variable "s3_bucket_access_key" {
  default = "AKIAIOSFODNN7EXAMPLE"
  type        = string
}

variable "s3_bucket_secret_key" {
  default = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  type        = string
  sensitive = true
}

variable "s3_bucket_url" {
  default = "https://mybucket.s3-myregion.amazonaws.com/mydataset/"
  type        = string
}
