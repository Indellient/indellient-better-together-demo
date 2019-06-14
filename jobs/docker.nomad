job "docker" {
  type = "service"
  datacenters = ["dc1"]

  group "webservice-cache" {
    count = 1

    task "webservice" {
      driver = "docker"

      config {
        image = "redis:3.2"
        labels {
          group = "webservice-cache"
        }
      }
    }
  }
}
