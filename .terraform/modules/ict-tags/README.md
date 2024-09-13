# ICT Cloud Team tagging module

This module enforces the use of default tag values for resources created.

## Required tag values

* billing_dept
* technical_owner
* product_owner
* project_name

## Optional tag values

* extra_tags - Map of custom tag values

## Example

```HCL
module "tf_tags" {
    source          = "app.terraform.io/Imperial-College/ict-tags/terraform"
    billing_dept    = "ICT"
    technical_owner = "Martin Grune"
    product_owner   = "Roz Turner"
    project_name    = "Some cloud project"
    extra_tags      = {
        someExtraTag    = "tag value"
        anotherExtraTag = "tag value"
    }
}
```
