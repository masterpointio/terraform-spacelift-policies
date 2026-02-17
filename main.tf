locals {
  body_map = {
    for name, policy in var.policies : name => merge(
      policy.body != null ? { body = policy.body } : {},
      policy.body_url != null ? { body = data.http.default[name].response_body } : {},
      policy.body_file != null ? { body = file(policy.body_file) } : {},
    )
  }
}

resource "spacelift_policy" "default" {
  for_each = var.policies

  name        = module.this.id != "" ? format("%s-%s", module.this.id, each.key) : each.key
  body        = local.body_map[each.key].body
  type        = each.value.type
  description = each.value.description
  engine_type = each.value.engine_type
  labels      = each.value.labels
  space_id    = each.value.space_id
}

data "http" "default" {
  for_each = {
    for name, policy in var.policies : name => policy
    if policy.body_url != null
  }
  url = each.value.body_url
}
