job "docker" {
  type = "service"
  datacenters = ["dc1"]

  group "web" {
    count = 1

    task "sample-node-app" {
      driver = "docker"

      config {
        image = "bettertogetherdemo/sample-node-app:latest"

        port_map {
          http = 8000
        }

        labels {
          group = "web"
        }
      }

      env {
        "HAB_LICENSE" = "accept"
      }

      resources {
        network {
          port "http" {
            static = 8000
          }
        }
      }
    }
  }
}
