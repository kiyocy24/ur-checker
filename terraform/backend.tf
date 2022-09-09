terraform {
  backend "gcs" {
    bucket  = "kiyocy24-tfstate"
    prefix  = "terraform/state"
  }
}
