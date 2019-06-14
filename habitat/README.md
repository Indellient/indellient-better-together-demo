# Habitat Packages

The Habitat packages `nomad_server` and `nomad_client` are the COTS packages that are loaded on the Azure VMs. The package `sample-node-app` represents an organization's in-house application which has been packaged using Habitat, exported as a Docker image using `hab pkg export docker [hart file]`, and had its Docker image uploaded to DockerHub and run on the Nomad client VM.
