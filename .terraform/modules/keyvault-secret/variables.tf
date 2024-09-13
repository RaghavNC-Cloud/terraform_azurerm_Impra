# Keyvault Secret Variables
variable "keyvault_secret_config" {
  description = <<-EOF
    Parameters used to configure `keyvault secret config`
      `name` = (`Required` Specifies the name of the Key Vault Secret.)

      `content_type` = (`Optional` Specifies the content type for the Key Vault Secret.)

      `not_before_date` = (`Optional` Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').)

      `expiration_date` = (`Optional` Expiration UTC datetime (Y-m-d'T'H:M:S'Z').)

      `kv_resource_group_name` = (`Required` Name of the resource group in which Keyvault exists)

      `kv_name` = (`Required` Name of the Keyvault to store the secret)
  EOF
  type = map(object({
    name                   = string
    secret_value           = optional(string)
    content_type           = optional(string)
    not_before_date        = optional(string)
    expiration_date        = optional(string)
    kv_resource_group_name = string
    kv_name                = string
  }))
}

variable "azurerm_client_config" {
  description = "AzureRM provider configuration"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
