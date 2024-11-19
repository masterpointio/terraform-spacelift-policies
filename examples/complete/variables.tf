variable "policies" {
  description = "Map of Policies with their policyurations."
  type = map(object({
    body        = optional(string, null)
    body_url    = optional(string, null)
    body_file   = optional(string, null)
    type        = string
    description = optional(string, null)
    labels      = optional(list(string), [])
    space_id    = optional(string, null)
  }))
  default = {}

  validation {
    condition = alltrue([
      for name, policy in var.policies : (
        length(compact([
          policy.body,
          policy.body_url,
          policy.body_file
        ])) == 1
      )
    ])
    error_message = "Each Policy must have exactly one of 'body', 'body_url', or 'body_file' defined."
  }

  validation {
    condition = alltrue([
      for name, policy in var.policies :
      contains([
        "ACCESS",
        "APPROVAL",
        "GIT_PUSH",
        "INITIALIZATION",
        "LOGIN",
        "PLAN",
        "TASK",
        "TRIGGER",
        "NOTIFICATION"
      ], policy.type)
    ])
    error_message = <<-EOT
      Each policy must have a `type` that is one of the allowed values:
        - ACCESS
        - APPROVAL
        - GIT_PUSH
        - INITIALIZATION
        - LOGIN
        - PLAN
        - TASK
        - TRIGGER
        - NOTIFICATION

      Deprecated types are not allowed. If you're using any of the following deprecated types, please update them:
        - STACK_ACCESS (use ACCESS instead)
        - TASK_RUN (use TASK instead)
        - TERRAFORM_PLAN (use PLAN instead)
    EOT
  }
}
