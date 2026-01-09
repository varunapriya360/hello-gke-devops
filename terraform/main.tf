resource "google_container_cluster" "gke" {
  name     = "hello-gke"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary" {
  cluster   = google_container_cluster.gke.name
  location  = var.zone
  node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
