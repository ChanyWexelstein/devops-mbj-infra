output "instance_ip" {
  description = "The external IP of the instance"
  value       = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}
