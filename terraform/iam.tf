resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "Github Actions"
}

resource "google_project_iam_member" "github_actions" {
  project  = "kiyocy24"
  member   = "serviceAccount:github-actions@kiyocy24.iam.gserviceaccount.com"
  for_each = toset([
    "roles/cloudfunctions.admin",
  ])
  role     = each.key
}
