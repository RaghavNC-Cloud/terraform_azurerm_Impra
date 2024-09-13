variable "creator" {
  description = "Resource creator"
  type        = string
  default     = "ICT Cloud Team"
}

variable "billing_dept" {
  description = "Department billed for resources"
  type        = string
  default     = null
}

variable "technical_owner" {
  description = "Technical owner of the deployed application stack"
  type        = string
  default     = null
}

variable "product_owner" {
  description = "Product owner"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Name of the project to which the resources belong"
  type        = string
}

variable "extra_tags" {
  default     = {}
  description = "Extra tags to add"
  type        = map(string)
}
