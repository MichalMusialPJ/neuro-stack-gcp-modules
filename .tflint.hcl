plugin "google" {
  source  = "github.com/terraform-linters/tflint-ruleset-google"
  version = "~> 0.30"
  enabled = true
}

config {
  call_module_type = "local"
}
