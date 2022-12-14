resource "google_cloud_scheduler_job" "urchecker" {
  name        = "urchecker-job"
  description = "every hour"
  schedule    = "0 * * * *"
  time_zone   = "Asia/Tokyo"
  region      = "asia-northeast1"
  paused      = false

  pubsub_target {
    topic_name = google_pubsub_topic.urchecker.id
    data       = base64encode("{\"keyWord\":\"当サイトからご案内できる空室はございません\",\"urls\":[\"https://www.ur-net.go.jp/chintai/kanto/kanagawa/40_3840.html\"],\"notificationMessage\":\"空室が見つかりました\"}")
  }
}
