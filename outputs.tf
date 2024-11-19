output "all" {
  description = "A map of Spacelift Policies with their attributes."
  value = {
    for name, policy in spacelift_policy.default : name => policy
  }
}
