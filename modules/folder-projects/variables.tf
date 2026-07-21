variable "org_id" {
  description = "GCP organisation ID (numeric, without 'organizations/' prefix)"
  type        = string
}

variable "billing_account" {
  description = "Billing account ID attached to every created project"
  type        = string
}

variable "folder_name" {
  description = "Display name of the folder to create under the organisation"
  type        = string
}

variable "projects" {
  description = "Map of projects to create inside the folder. Key is used as a stable Terraform identifier."
  type = map(object({
    project_id   = string
    display_name = string
    services     = optional(list(string), [])
    labels       = optional(map(string), {})
  }))
  default = {}
}
