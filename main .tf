provider "google" {
  credentials = file("terraform-chany-wexelshtein-eec74dcbcb56.json")
  project     = var.project
  region      = var.region
}

# יצירת מכונה וירטואלית עם תבנית של מכונה
resource "google_compute_instance" "example" {
  name         = "chany-wexelshtein-instance"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file("startup.sh")
  tags = ["allow-http", "allow-ssh", "health-check"]
}

# יצירת תבנית מכונה
resource "google_compute_instance_template" "example" {
  name         = "chany-wexelshtein-instance-template"
  machine_type = var.machine_type
  region       = var.region
  tags         = ["allow-http", "allow-ssh", "health-check"]

  disk {
    source_image = "projects/debian-cloud/global/images/family/debian-12"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file("C:/Users/חיה וקסלשטיין/devops-mbj-infra/startup.sh")
}

# יצירת קבוצה עם מנהל קבוצה של מכונות
resource "google_compute_instance_group_manager" "example_mig" {
  name                  = "chany-wexelshtein-mig"
  zone                  = var.zone
  base_instance_name    = "chany-wexelshtein-instance"
  version {
    instance_template = google_compute_instance_template.example.id
  }
  target_size = 1

  depends_on = [google_compute_instance_template.example]
}

# יצירת חומת אש לאפשר גישה לפורט 80 (HTTP)
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# יצירת חומת אש לאפשר גישה לפורט 22 (SSH)
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# יצירת חומת אש לאפשר גישה עבור בדיקות בריאות (Health Checks)
resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
