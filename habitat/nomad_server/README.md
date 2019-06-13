# Habitat package: Nomad Server 

## Description

[Nomad](https://nomadproject.io) is an easy-to-use, flexible, and performant workload orchestrator.

This plan provides the static binary for execution and the configuration for a Nomad server.

## Usage

```
hab svc load better-together-demo/nomad_server
```

## Topology

Nomad can be deployed as a single node with a `standalone` topology. This package is intended for a short demo, and hence a topology allowing for a Nomad cluster is outside the scope of this package.
