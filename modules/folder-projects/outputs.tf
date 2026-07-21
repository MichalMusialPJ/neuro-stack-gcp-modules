output "folder_id" {
  description = "GCP folder resource name (e.g. 'folders/123456')"
  value       = google_folder.this.name
}

output "project_ids" {
  description = "Map of project key → GCP project ID string"
  value       = { for k, v in google_project.this : k => v.project_id }
}

output "project_numbers" {
  description = "Map of project key → GCP project number"
  value       = { for k, v in google_project.this : k => v.number }
}
