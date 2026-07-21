variables {
  org_id          = "000000000000"
  billing_account = "000000-000000-000000"
  folder_name     = "neuro-stack"

  projects = {
    networking = {
      project_id   = "ns-networking-test"
      display_name = "Networking"
      services     = ["compute.googleapis.com"]
      labels       = { team = "platform" }
    }
    ml = {
      project_id   = "ns-ml-test"
      display_name = "ML Platform"
      services     = ["aiplatform.googleapis.com", "bigquery.googleapis.com"]
      labels       = { team = "ml" }
    }
  }
}

run "outputs_contain_all_projects" {
  command = plan

  assert {
    condition     = length(output.project_ids) == 2
    error_message = "Expected 2 projects in output"
  }

  assert {
    condition     = contains(keys(output.project_ids), "networking")
    error_message = "Expected 'networking' in project_ids"
  }

  assert {
    condition     = contains(keys(output.project_ids), "ml")
    error_message = "Expected 'ml' in project_ids"
  }
}
