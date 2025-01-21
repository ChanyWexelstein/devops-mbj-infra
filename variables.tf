variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the GCP resources"
  type        = string
}

variable "zone" {
  description = "The zone for the GCP resources"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the instance"
  type        = string
}
