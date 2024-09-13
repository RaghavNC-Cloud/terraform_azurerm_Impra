variable "resource_groups" {
  description = <<-EOF
  Parameters used to create `Resource Group`
  `name`     = (`Required` The name of the resource group.)

  `location` = (`Required` The location where the resource group should be created. Defaults to `uksouth`)
  EOF
  type = map(object({
    name     = string
    location = optional(string, "uksouth")
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
