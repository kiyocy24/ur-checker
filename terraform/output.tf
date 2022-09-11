output "service_account_github_actions_email" {
  description = "Actionsで使用するサービスアカウント"
  value       = google_service_account.github_actions.email
}

output "google_iam_workload_identity_pool_provider_github_name" {
  description = "Workload Identity Pool Provider ID"
  value       = google_iam_workload_identity_pool_provider.github_actions.name
}
