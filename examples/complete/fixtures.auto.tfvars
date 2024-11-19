enabled = true

namespace = "mp"

policies = {
  notification-finished-runs = {
    # Source: https://docs.spacelift.io/concepts/policy/notification-policy#filtering-and-routing-messages
    body = <<EOF
    package spacelift
    slack[{"channel_id": "C0000000000"}] {
      input.run_updated != null
      run := input.run_updated.run
      run.state == "FINISHED"
    }
    EOF
    type = "NOTIFICATION"
  }
  trigger-administrative = {
    body_url = "https://raw.githubusercontent.com/cloudposse/terraform-spacelift-cloud-infrastructure-automation/1.6.0/catalog/policies/trigger.administrative.rego"
    type     = "TRIGGER"
  }
  plan-deny-static-aws-creds = {
    body_file = "./policies/plan.deny-static-aws-creds.rego"
    type      = "PLAN"
  }
}
