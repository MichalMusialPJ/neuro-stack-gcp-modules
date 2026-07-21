resource "google_folder" "this" {
  display_name = var.folder_name
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "this" {
  for_each = var.projects

  name            = each.value.display_name
  project_id      = each.value.project_id
  folder_id       = google_folder.this.folder_id
  billing_account = var.billing_account
  labels          = each.value.labels
}

locals {
  project_services = merge([
    for pk, pv in var.projects : {
      for svc in pv.services : "${pk}/${svc}" => {
        project = google_project.this[pk].project_id
        service = svc
      }
    }
  ]...)
}

resource "google_project_service" "this" {
  for_each = local.project_services

  project                    = each.value.project
  service                    = each.value.service
  disable_on_destroy         = false
  disable_dependent_services = false
}
