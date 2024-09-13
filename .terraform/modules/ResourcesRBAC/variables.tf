variable "rbac_config" {
  description = <<-EOF
    `role_definition_name` -  (`Optional` The name of a built-in Role. Changing this forces a new resource to be created.)

    `scope` - (`Required` The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG.)

    `object_id` - (`Required` The object ID of the group or user or service principle (Enterprise application object ID) to assign the Role Definition to.)

    `skip_service_principal_aad_check` (`Optional` If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. Defaults to `false`.)
  EOF
  type = map(object({
    role_definition_name             = string
    scope                            = string
    object_id                        = string
    skip_service_principal_aad_check = optional(bool, false)
  }))
}
