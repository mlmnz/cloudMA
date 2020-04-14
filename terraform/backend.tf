terraform {
  backend "gcs" {
    bucket  = "cloudma-terraform_statetf-state"
  }
}