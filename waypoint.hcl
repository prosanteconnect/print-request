project = "print-request"

# Labels can be specified for organizational purposes.
labels = { "domaine" = "psc" }

runner {
  enabled = true
  data_source "git" {
    url = "https://github.com/prosanteconnect/print-request.git"
    ref = var.datacenter
  }
  poll {
    enabled = true
  }
}

# An application to deploy.
app "print-request" {
  # the Build step is required and specifies how an application image should be built and published. In this case,
  # we use docker-pull, we simply pull an image as is.
  build {
    use "docker" {
      dockerfile = "${path.app}/${var.dockerfile_path}"
    }
    # Uncomment below to use a remote docker registry to push your built images.
    registry {
      use "docker" {
        image = "${var.registry_path}/print-request"
        tag   = gitrefpretty()
        encoded_auth = filebase64("/secrets/dockerAuth.json")
      }
    }
  }

  # Deploy to Nomad
  deploy {
    use "nomad-jobspec" {
      jobspec = templatefile("${path.app}/print-request.nomad.tpl", {
        datacenter = var.datacenter
        registry_path = var.registry_path
      })
    }
  }
}

variable "datacenter" {
  type    = string
  default = "henix_docker_platform_dev"
}

variable "registry_username" {
  type    = string
  default = ""
}

variable "registry_password" {
  type    = string
  default = ""
}


variable "dockerfile_path" {
  type = string
  default = "Dockerfile"
}

variable "proxy_address" {
  type = string
  default = ""
}

variable "registry_path" {
  type = string
  default = "registry.repo.proxy-dev-forge.asip.hst.fluxus.net/prosanteconnect"
}
