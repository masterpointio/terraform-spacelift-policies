output "policies" {
  description = "A map of Spacelift Policies with their attributes."
  value       = module.policies.all
}
