variable "private_endpoints" {
  description = <<-EOF
  Parameters used to create `Azure Key Vault Private Endpoint`

  `name` = (The name of the Key Vault Private Endpoint.)

  `resource_group_name` = (The name of the resource group in which to create the Key Vault Private Endpoint.)

  `location` = (The Azure region where the Key Vault Private Endpoint will be created.Defaults to `uksouth`)

  `subnet_id` = (`Required` Subnet ID for private Endpoint)

  `private_dns_zone_group` - (`Optional` A private_dns_zone_group block as defined below.)

  `private_dns_zone_ids` - (`Required` Specifies the list of Private DNS Zones to include within the private_dns_zone_group.)

  `private_service_connection` = (The private service connection settings for the Key Vault Private Endpoint.)

  `private_connection_resource_id` - (`Required` The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to.)

  `is_manual_connection` = (`Optional`Does the Private Endpoint require Manual Approval from the remote resource owner? Defaults to `false`)

  `subresource_names` = (`Required` The list of subresource names associated with the private service connection.)
  EOF
  type = map(object({
    name                = string
    resource_group_name = string
    location            = optional(string, "uksouth")
    subnet_id           = string

    private_dns_zone_group = object({
      private_dns_zone_ids = list(string)
    })

    private_service_connection = object({
      private_connection_resource_id = string
      is_manual_connection           = optional(bool, false)
      subresource_names              = list(string)
    })
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
