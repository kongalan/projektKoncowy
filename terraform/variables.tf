variable "pm_api_url" {
  type = string
}

variable "pm_token_id" {
  type      = string
  sensitive = true
}
variable "pm_token_secret" {
  sensitive = true  
}

variable "ssh_key" {
  type = string
  sensitive = true
}