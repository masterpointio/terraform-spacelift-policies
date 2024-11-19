module "policies" {
  source = "../../"

  policies = var.policies
  context  = module.this.context
}
