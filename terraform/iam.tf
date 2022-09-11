resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "Github Actions"
}

resource "google_project_iam_member" "github_actions" {
  project  = "kiyocy24"
  member   = "serviceAccount:github-actions@kiyocy24.iam.gserviceaccount.com"
  for_each = toset([
    "roles/cloudfunctions.admin",
    "roles/iam.serviceAccountUser",
  ])
  role     = each.key
}

resource "google_service_account_iam_member" "github_account_iam" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository/${var.repo_name}"
}

resource "google_iam_workload_identity_pool" "github_actions" {
  provider                  = google-beta
  project                   = var.project_name
  workload_identity_pool_id = "github-actions-pool-2" # TODO: "-2"消す
  display_name              = "Github Actions"
  description               = "Workload Identity Pool for GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github_actions" {
  provider                           = google-beta
  project                            = var.project_name
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions"
  display_name                       = "github-actions"
  description                        = "OIDC identity pool provider for GitHub Actions"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.owner"      = "assertion.repository_owner"
    "attribute.refs"       = "assertion.ref"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
