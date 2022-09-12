resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret-version"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version-basic-line-secret" {
  secret      = google_secret_manager_secret.secret-basic.id
  secret_data = var.line_secret
}

resource "google_secret_manager_secret_version" "secret-version-basic-line-token" {
  secret      = google_secret_manager_secret.secret-basic.id
  secret_data = var.line_token
}
