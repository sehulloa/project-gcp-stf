
provider "google" {
    credentials = file("./project-gcp-stf-79b7e5528ae6.json")
}

resource "google_container_cluster" "default" {
  name         = var.name
  project      = var.project
  description  = "Cluster Project GCP DEV"
  location     = var.location

  enable_legacy_abac       = true
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name = var.name-pool
  project = var.project
  location = var.location
  cluster = google_container_cluster.default.name
  node_count = var.initial_node_count

  node_config {
    preemptible = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
