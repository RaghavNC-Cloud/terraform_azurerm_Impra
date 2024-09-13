locals {
  default_tags = {
    terraform_managed = true
    creator           = var.creator
    billing_dept      = lower(var.billing_dept)
    technical_owner   = var.technical_owner
    product_owner     = var.product_owner
    project_name      = var.project_name
  }

  tags = merge(local.default_tags, var.extra_tags)
}
