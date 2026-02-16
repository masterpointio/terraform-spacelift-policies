terraform {
  required_version = ">= 1.0"

  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">= 1.36"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.0"
    }
  }
}

