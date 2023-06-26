
provider "template" {
  version = "~> 2.1"
}

data "template_file" "dockerfile" {
  template = file("${path.module}/Dockerfile.tpl")

  vars {
    name = "George Ambre"
  }
}

resource "docker_image" "ekow" {
  name = "georgeambre/ekow:v1"

  build {
    context    = path.module
    dockerfile = data.template_file.dockerfile.rendered
  }
}

output "image_id" {
  value = docker_image.ekow.id
}

resource "docker_container" "Nana" {
  name  = "Nana"
  image = "ekow"
}

data "template_file" "example" {
  template = file("example.tpl")

  vars {
    template_variable = "ekow value"
  }
}

output "docker_file" {
  value = data.template_file.ekow.rendered
}



