# Habitat package: Nomad Client

## Description

[Nomad](https://nomadproject.io) is an easy-to-use, flexible, and performant workload orchestrator.

This plan provides the static binary for execution and the configuration for a Nomad client, with support for the [Docker Driver](https://www.nomadproject.io/docs/drivers/docker.html).

## Usage

```
hab svc load better-together-demo/nomad_client --bind server:nomad_server.default
```

## Topology

Nomad can be deployed as a single node with a `standalone` topology, binding to a Nomad server using the `server` bind name.
