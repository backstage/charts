# Backstage Helm Chart

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

> Disclaimer: This Helm chart deploys a pre-packaged container image which contains a vanilla Backstage instance for demo purposes. This image is probably not suitable for use in production. For further customization of the Backstage instance (plugin installation, UI changes, etc.) please create your own custom instance and container image. For details please consult the [Backstage documentation](https://backstage.io/docs)

## Scope

This chart focuses on providing users the same experience and functionality no matter what flavor of Kubernetes they use. This chart will support only patterns that are either customary for all Kubernetes flavors, are commonly used in the Bitnami charts ecosystem, and recognized as Backstage official patterns.

We welcome other, more specialized, charts to use this cannonical chart as a direct dependency, expanding the feature set further, beyond this scope.

A list of derived charts:
- OpenShift specialized chart: [Janus Backstage Helm chart](https://github.com/janus-idp/helm-backstage/tree/main/charts/backstage)

## Usage

Charts are available in the following formats:

* [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
* [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add backstage https://backstage.github.io/charts
```

Once the chart has been added, install one of the available charts:

```console
helm upgrade -i <release_name> backstage/backstage
```

### Installing from an OCI Registry

Charts are also available in OCI format. The list of available charts can be found [here](https://github.com/orgs/backstage/packages?repo_name=charts).

Install one of the available charts:

```shell
helm upgrade -i <release_name> oci://ghcr.io/backstage/charts/backstage --version=<version>
```

## Helm Chart Values

This README provides documentation for the configurable parameters in the Helm chart's `values.schema.json` file. These parameters can be customized when installing or upgrading your Backstage application using Helm.

### Table of Contents
- [Backstage Helm Chart](#backstage-helm-chart)
  - [Scope](#scope)
  - [Usage](#usage)
    - [Installing from the Chart Repository](#installing-from-the-chart-repository)
    - [Installing from an OCI Registry](#installing-from-an-oci-registry)
  - [Helm Chart Values](#helm-chart-values)
    - [Table of Contents](#table-of-contents)
    - [Global Parameters](#global-parameters)
    - [Backstage Parameters](#backstage-parameters)
    - [Service Parameters](#service-parameters)
    - [Network Policy](#network-policy)
    - [PostgreSQL Configuration](#postgresql-configuration)
  - [Backstage Chart](#backstage-chart)

---

### Global Parameters
| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |s
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |

---

### Backstage Parameters
| Name                           | Description                                     | Value |
| ------------------------------ | ----------------------------------------------- | ----- |
| `backstage.replicas`           | Number of deployment replicas                   | `1`   |
| `backstage.revisionHistoryLimit` | The count of deployment revisions               | `10`  |
| `backstage.image.registry`     | Backstage image registry                         | `"ghcr.io"`  |
| `backstage.image.repository`   | Backstage image repository                       | `"backstage/backstage"`  |
| `backstage.image.tag`          | Backstage image tag                              | `"latest"`  |
| `backstage.image.pullPolicy`   | Specify image pull policy                        | `"Always"`  |
| `backstage.image.pullSecrets`  | Optionally specify imagePullSecrets             | `[]`  |
| `backstage.image.debug`        | Set to true to see extra information on logs    | `false` |
| `backstage.containerPorts.backend` | Backstage backend port                         | `7007` |
| `backstage.command`           | Backstage container command                      | `["node", "packages/backend"]`  |
| `backstage.args`              | Backstage container command arguments            | `[]`   |
| `backstage.extraAppConfig`    | Extra app configuration files to inline into arguments | `[]` |
| `backstage.extraContainers`    | Deployment sidecars                              | `[]`   |
| `backstage.extraEnvVars`      | Backstage container environment variables         | `[]`   |
| `backstage.extraEnvVarsSecrets` | Backstage container environment variables from Secrets | `[]` |
| `backstage.extraVolumeMounts`  | Backstage container additional volume mounts      | `[]`   |
| `backstage.extraVolumes`       | Backstage container additional volumes            | `[]`   |
| `backstage.initContainers`     | Backstage container init containers                | `[]`   |
| `backstage.installDir`        | Directory containing the Backstage installation    | `"/app"` |
| `backstage.resources`         | Resource requests/limits                          | `{}`   |
| `backstage.readinessProbe`    | Readiness probe                                  | `{}`   |
| `backstage.livenessProbe`     | Liveness probe                                   | `{}`   |
| `backstage.startupProbe`      | Startup probe                                    | `{}`   |
| `backstage.podSecurityContext` | Security settings for a Pod                       | `{}`   |
| `backstage.containerSecurityContext` | Security settings for a Container               | `{}`   |
| `backstage.appConfig`         | Generates ConfigMap and configures it in Backstage pods | `{}` |
| `backstage.nodeSelector`      | Node labels for pod assignment                    | `{}`   |
| `backstage.tolerations`       | Node tolerations for server scheduling to nodes    | `[]`   |
| `backstage.podAnnotations`     | Annotations to add to the backend deployment pods | `{}`   |
| `backstage.podLabels`         | Labels to add to the backend deployment pods      | `{}`   |
| `backstage.annotations`       | Additional custom annotations for the Deployment resource | `{}` |

---

### Service Parameters
| Name                      | Description                                           | Value  |
| ------------------------- | ----------------------------------------------------- | ------ |
| `service.type`            | Kubernetes Service type                              | `"ClusterIP"`  |
| `service.ports.backend`   | Backstage svc port number                            | `7007`  |
| `service.ports.name`      | Backstage svc port name                              | `"http-backend"`  |
| `service.ports.targetPort` | Backstage svc target port referencing receiving pod container port | `"backend"` |
| `service.nodePorts.backend` | Node port for backend                                | `""`  |
| `service.sessionAffinity` | Control where client requests go, to the same pod or round-robin | `"None"`  |
| `service.clusterIP`       | Backstage service Cluster IP                        | `""`  |
| `service.loadBalancerIP`  | Backstage service Load Balancer IP                  | `""`  |
| `service.loadBalancerSourceRanges` | Load Balancer sources                            | `[]`  |
| `service.externalTrafficPolicy` | Backstage service external traffic policy        | `"Cluster"`  |
| `service.annotations`      | Additional custom annotations for Backstage service | `{}`  |
| `service.extraPorts`      | Extra ports to expose in the Backstage service      | `[]`  |

---

### Network Policy
| Name                      | Description                                           | Value  |
| ------------------------- | ----------------------------------------------------- | ------ |
| `networkPolicy.enabled`   | Specifies whether a NetworkPolicy should be created  | `false`  |
| `networkPolicy.externalAccess` | Probably custom ingress rules for the network policy | `{}`   |
| `networkPolicy.egressRules.customRules` | Custom egress rules for the network policy | `[]`   |

---

### PostgreSQL Configuration
For PostgreSQL
| Name                           | Description                                           | Value  |
| ------------------------------ | ----------------------------------------------------- | ------ |
| `postgresql`                   | PostgreSQL chart configuration                        | See [here](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml) |
| `serviceAccount.create`        | Enable the creation of a ServiceAccount for Backstage pods | `false`  |
| `serviceAccount.name`          | Name of the ServiceAccount to use                     | `""`   |
| `serviceAccount.labels`        | Additional custom labels to the service ServiceAccount | `{}`   |
| `serviceAccount.annotations`    | Additional custom annotations for the ServiceAccount   | `{}`   |
| `serviceAccount.automountServiceAccountToken` | Auto-mount the service account token in the pod | `true`  |
| `metrics.serviceMonitor.enabled` | If enabled, a ServiceMonitor resource for Prometheus Operator is created | `false` |
| `metrics.serviceMonitor.annotations` | ServiceMonitor annotations                      | `{}`   |
| `metrics.serviceMonitor.labels` | Additional ServiceMonitor labels                      | `{}`   |
| `metrics.serviceMonitor.interval` | ServiceMonitor scrape interval                        | `null`  |
| `metrics.serviceMonitor.path`    | ServiceMonitor endpoint path                          | `"/metrics"`  |


## Backstage Chart

More information can be found by inspecting the [backstage chart](charts/backstage).