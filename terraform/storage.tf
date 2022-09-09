resource "google_storage_bucket" "tfstate" {
  name          = "kiyocy24-tfstate"
  force_destroy = false
  uniform_bucket_level_access = true
  location      = "asia-northeast1"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions         = 30
      days_since_noncurrent_time = 30
    }
  }
}
