<!--- app-name: Backstage -->

# Backstage

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

## TL;DR

```console
helm repo add backstage https://backstage.github.io/charts
helm install my-release backstage
```

## Introduction

This chart bootstraps a [Backstage](https://backstage.io/docs/deployment/docker) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add backstage https://charts.backstage.io
helm install my-release backstage
```

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |

### Common parameters

| Name                     | Description                                                                             | Value           |
| ------------------------ | --------------------------------------------------------------------------------------- | --------------- |
| `kubeVersion`            | Override Kubernetes version                                                             | `""`            |
| `nameOverride`           | String to partially override common.names.fullname                                      | `""`            |
| `fullnameOverride`       | String to fully override common.names.fullname                                          | `""`            |
| `clusterDomain`          | Default Kubernetes cluster domain                                                       | `cluster.local` |
| `commonLabels`           | Labels to add to all deployed objects                                                   | `{}`            |
| `commonAnnotations`      | Annotations to add to all deployed objects                                              | `{}`            |
| `extraDeploy`            | Array of extra objects to deploy with the release                                       | `[]`            |
| `diagnosticMode.enabled` | Enable diagnostic mode (all probes will be disabled and the command will be overridden) | `false`         |
| `diagnosticMode.command` | Command to override all containers in the statefulset                                   | `["sleep"]`     |
| `diagnosticMode.args`    | Args to override all containers in the statefulset                                      | `["infinity"]`  |

### Backstage parameters

| Name                         | Description                                          | Value                          |
| ---------------------------- | ---------------------------------------------------- | ------------------------------ |
| `backstage.image.registry`   | Backstage image registry                             | `""`                           |
| `backstage.image.repository` | Backstage image repository                           | `""`                           |
| `backstage.image.tag`        | Backstage image tag (immutable tags are recommended) | `""`                           |
| `image.pullPolicy`           | Backstage image pull policy                          | `IfNotPresent`                 |
| `image.pullSecrets`          | Specify docker-registry secret names as an array     | `[]`                           |
| `command`                    | Override Backstage container command                 | `[]` |
| `args`                       | Override Backstage container arguments               | `[]`                           |
| `extraEnvVars`               | Extra environment variables to add to Backstage pods | `[]`                           |
| `extraEnvVarsCM`             | ConfigMap with extra environment variables           | `""`                           |
| `extraEnvVarsSecrets`         | Secret with extra environment variables              | `""`                           |

### Traffic Exposure parameters

| Name                               | Description                                                      | Value       |
| ---------------------------------- | ---------------------------------------------------------------- | ----------- |
| `service.type`                     | Kubernetes Service type                                          | `ClusterIP` |
| `service.ports.backend`            | Port for client connections                                      | `7007`      |
| `service.nodePorts.backend`        | Node port for client connections                                 | `""`        |
| `service.sessionAffinity`          | Control where client requests go, to the same pod or round-robin | `None`      |
| `service.clusterIP`                | Backstage service Cluster IP                                     | `""`        |
| `service.loadBalancerIP`           | Backstage service Load Balancer IP                               | `""`        |
| `service.loadBalancerSourceRanges` | Backstage service Load Balancer sources                          | `[]`        |
| `service.externalTrafficPolicy`    | Backstage service external traffic policy                        | `Cluster`   |
| `service.annotations`              | Additional custom annotations for Backstage service              | `{}`        |
| `service.extraPorts`               | Extra ports to expose in Backstage                               | `[]`        |
