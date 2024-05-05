terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  # Configuration options
project = "expanded-stone-416701"
region = "us-west2"
zone = "us-west2-b"
credentials = "expanded-stone-416701-cd04e24d3d1e.json"
}


resource "google_storage_bucket" "bucket" {
  name     = "zwarrior90-bucket"
  location = "US"
  project  = "expanded-stone-416701"

  storage_class = "STANDARD"
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_object" "indexpage" {
  name         = "index.html"
  content      = "<html><body>Hello World!</body></html>"
  content_type = "text/html"
  bucket       = google_storage_bucket.bucket.id
}

output "public_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.indexpage.name}"
  description = "The public URL to access the object."
}
