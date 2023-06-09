
# Backstage Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/backstage)](https://artifacthub.io/packages/search?repo=backstage)
![Version: 1.1.2](https://img.shields.io/badge/Version-1.1.2-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for deploying a Backstage application

**Homepage:** <https://backstage.io>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Backstage |  | <https://backstage.io> |

## Source Code

* <https://github.com/backstage/charts>
* <https://github.com/backstage/backstage>

---

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

> Disclaimer: This Helm chart deploys a pre-packaged container image which contains a vanilla Backstage instance for demo purposes. This image is probably not suitable for use in production. For further customization of the Backstage instance (plugin installation, UI changes, etc.) please create your own custom instance and container image. For details please consult the [Backstage documentation](https://backstage.io/docs)

## TL;DR

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add backstage https://backstage.github.io/charts

helm install my-release backstage/backstage
```

## Introduction

This chart bootstraps a [Backstage](https://backstage.io/docs/deployment/docker) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- [Backstage container image](https://backstage.io/docs/deployment/docker)

## Scope

This chart focuses on providing users the same experience and functionality no matter what flavor of Kubernetes they use. This chart will support only patterns that are either customary for all Kubernetes flavors, are commonly used in the Bitnami charts ecosystem, and recognized as Backstage official patterns.

We welcome other, more specialized, charts to use this cannonical chart as a direct dependency, expanding the feature set further, beyond this scope.

A list of derived charts:
- OpenShift specialized chart: [Janus Backstage Helm chart](https://github.com/janus-idp/helm-backstage/tree/main/charts/backstage)

## Usage

Chart is available in the following formats:

- [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
- [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```console
helm repo add backstage https://backstage.github.io/charts
```

Once the chart has been added, install one of the available charts:

```console
helm upgrade -i <release_name> backstage/backstage
```

### Installing from an OCI Registry

Chart is also available in OCI format. The list of available releases can be found [here](https://github.com/backstage/charts/pkgs/container/charts%2Fbackstage).

Install one of the available versions:

```shell
helm upgrade -i oci://ghcr.io/backstage/charts/backstage --version=<version>
```

> **Tip**: List all releases using `helm list`

### Uninstalling the Chart

To uninstall/delete the `my-backstage-release` deployment:

```console
helm uninstall my-backstage-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Requirements

Kubernetes: `>= 1.19.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.x.x |
| https://charts.bitnami.com/bitnami | postgresql | 12.x.x |

## Values

| Key | Description | Type | Default |
|-----|-------------|------|---------|
| backstage | Backstage parameters | object | See below |
| backstage.annotations | Additional custom annotations for the `Deployment` resource | object | `{}` |
| backstage.appConfig | Generates ConfigMap and configures it in the Backstage pods | object | `{}` |
| backstage.args | Backstage container command arguments | list | `[]` |
| backstage.command | Backstage container command | list | `["node","packages/backend"]` |
| backstage.containerPorts | Container ports on the Deployment | object | `{"backend":7007}` |
| backstage.containerSecurityContext | Security settings for a Container. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container | object | `{}` |
| backstage.extraAppConfig | Extra app configuration files to inline into command arguments | list | `[]` |
| backstage.extraContainers | Deployment sidecars | list | `[]` |
| backstage.extraEnvVars | Backstage container environment variables | list | `[]` |
| backstage.extraEnvVarsSecrets | Backstage container environment variables from Secrets | list | `[]` |
| backstage.extraVolumeMounts | Backstage container additional volume mounts | list | `[]` |
| backstage.extraVolumes | Backstage container additional volumes | list | `[]` |
| backstage.image.debug | Set to true if you would like to see extra information on logs | bool | `false` |
| backstage.image.pullPolicy | Specify a imagePullPolicy. Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' <br /> Ref: https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy | string | `"Always"` |
| backstage.image.pullSecrets | Optionally specify an array of imagePullSecrets.  Secrets must be manually created in the namespace. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ <br /> E.g: `pullSecrets: [myRegistryKeySecretName]` | list | `[]` |
| backstage.image.registry | Backstage image registry | string | `"ghcr.io"` |
| backstage.image.repository | Backstage image repository | string | `"backstage/backstage"` |
| backstage.image.tag | Backstage image tag (immutable tags are recommended) | string | `"latest"` |
| backstage.initContainers | Backstage container init containers | list | `[]` |
| backstage.installDir | Directory containing the backstage installation | string | `"/app"` |
| backstage.livenessProbe | Liveness Probe Backstage doesn't provide any health endpoints by default. A simple one can be added like this: https://backstage.io/docs/plugins/observability/#health-checks <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes <!-- E.g. livenessProbe:   failureThreshold: 3   httpGet:     path: /healthcheck     port: 7007     scheme: HTTP   initialDelaySeconds: 60   periodSeconds: 10   successThreshold: 1   timeoutSeconds: 2 | object | `{}` |
| backstage.nodeSelector | Node labels for pod assignment <br /> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector | object | `{}` |
| backstage.podAnnotations | Annotations to add to the backend deployment pods | object | `{}` |
| backstage.podSecurityContext | Security settings for a Pod.  The security settings that you specify for a Pod apply to all Containers in the Pod. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod | object | `{}` |
| backstage.readinessProbe | Readiness Probe Backstage doesn't provide any health endpoints by default. A simple one can be added like this: https://backstage.io/docs/plugins/observability/#health-checks <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes <!-- E.g. readinessProbe:   failureThreshold: 3   httpGet:     path: /healthcheck     port: 7007     scheme: HTTP   initialDelaySeconds: 30   periodSeconds: 10   successThreshold: 2   timeoutSeconds: 2 | object | `{}` |
| backstage.replicas | Number of deployment replicas | int | `1` |
| backstage.resources | Resource requests/limits <br /> Ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-requests-and-limits-of-pod-and-container <!-- E.g. resources:   limits:     memory: 1Gi     cpu: 1000m   requests:     memory: 250Mi     cpu: 100m --> | object | `{}` |
| backstage.tolerations | Node tolerations for server scheduling to nodes with taints <br /> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ | list | `[]` |
| clusterDomain | Default Kubernetes cluster domain | string | `"cluster.local"` |
| commonAnnotations | Annotations to add to all deployed objects | object | `{}` |
| commonLabels | Labels to add to all deployed objects | object | `{}` |
| diagnosticMode | Enable diagnostic mode in the Deployment | object | `{"args":["infinity"],"command":["sleep"],"enabled":false}` |
| diagnosticMode.args | Args to override all containers in the Deployment | list | `["infinity"]` |
| diagnosticMode.command | Command to override all containers in the Deployment | list | `["sleep"]` |
| diagnosticMode.enabled | Enable diagnostic mode (all probes will be disabled and the command will be overridden) | bool | `false` |
| extraDeploy | Array of extra objects to deploy with the release | list | `[]` |
| fullnameOverride | String to fully override common.names.fullname | string | `""` |
| global | Global parameters Global Docker image parameters Please, note that this will override the image parameters, including dependencies, configured to use the global value Current available global Docker image parameters: imageRegistry, imagePullSecrets and storageClass | object | See below |
| global.imagePullSecrets | Global Docker registry secret names as an array </br> E.g. `imagePullSecrets: [myRegistryKeySecretName]` | list | `[]` |
| global.imageRegistry | Global Docker image registry | string | `""` |
| ingress | Ingress parameters | object | `{"annotations":{},"className":"","enabled":false,"host":"","tls":{"enabled":false,"secretName":""}}` |
| ingress.annotations | Additional annotations for the Ingress resource | object | `{}` |
| ingress.className | Name of the IngressClass cluster resource which defines which controller will implement the resource (e.g nginx) | string | `""` |
| ingress.enabled | Enable the creation of the ingress resource | bool | `false` |
| ingress.host | Hostname to be used to expose the route to access the backstage application (e.g: backstage.IP.nip.io) | string | `""` |
| ingress.tls | Ingress TLS parameters | object | `{"enabled":false,"secretName":""}` |
| ingress.tls.enabled | Enable TLS configuration for the host defined at `ingress.host` parameter | bool | `false` |
| ingress.tls.secretName | The name to which the TLS Secret will be called | string | `""` |
| kubeVersion | Override Kubernetes version | string | `""` |
| metrics | Metrics configuration | object | `{"serviceMonitor":{"annotations":{},"enabled":false,"interval":null,"labels":{},"path":"/metrics"}}` |
| metrics.serviceMonitor | ServiceMonitor configuration <br /> Allows configuring your backstage instance as a scrape target for [Prometheus](https://github.com/prometheus/prometheus) using a ServiceMonitor custom resource that [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) can understand. | object | `{"annotations":{},"enabled":false,"interval":null,"labels":{},"path":"/metrics"}` |
| metrics.serviceMonitor.annotations | ServiceMonitor annotations | object | `{}` |
| metrics.serviceMonitor.enabled | If enabled, a ServiceMonitor resource for Prometheus Operator is created <br /> Prometheus Operator must be installed in your cluster prior to enabling. | bool | `false` |
| metrics.serviceMonitor.interval | ServiceMonitor scrape interval | string | `nil` |
| metrics.serviceMonitor.labels | Additional ServiceMonitor labels | object | `{}` |
| metrics.serviceMonitor.path | ServiceMonitor endpoint path <br /> Note that the /metrics endpoint is NOT present in a freshly scaffolded Backstage app. To setup, follow the [Prometheus metrics tutorial](https://github.com/backstage/backstage/blob/master/contrib/docs/tutorials/prometheus-metrics.md). | string | `"/metrics"` |
| nameOverride | String to partially override common.names.fullname | string | `""` |
| networkPolicy | Network policies <br /> Ref: https://kubernetes.io/docs/concepts/services-networking/network-policies/ | object | `{"egressRules":{"customRules":[]},"enabled":false,"externalAccess":{"from":[]}}` |
| networkPolicy.egressRules | Custom network policy rule | object | `{"customRules":[]}` |
| networkPolicy.egressRules.customRules | Additional custom egress rules e.g: customRules:   - to:       - namespaceSelector:           matchLabels:             label: example | list | `[]` |
| networkPolicy.enabled | networkPolicy.enabled Specifies whether a NetworkPolicy should be created | bool | `false` |
| postgresql | PostgreSQL [chart configuration](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml) | object | See below |
| postgresql.architecture | PostgreSQL architecture (`standalone` or `replication`) | string | `"standalone"` |
| postgresql.auth | The authentication details of the Postgres database | object | `{"existingSecret":"","password":"","secretKeys":{"adminPasswordKey":"admin-password","replicationPasswordKey":"replication-password","userPasswordKey":"user-password"},"username":"bn_backstage"}` |
| postgresql.auth.existingSecret | Name of existing secret to use for PostgreSQL credentials | string | `""` |
| postgresql.auth.password | Password for the custom user to create | string | `""` |
| postgresql.auth.secretKeys | The secret keys Postgres will look for to retrieve the relevant password | object | `{"adminPasswordKey":"admin-password","replicationPasswordKey":"replication-password","userPasswordKey":"user-password"}` |
| postgresql.auth.secretKeys.adminPasswordKey | The key in which Postgres will look for, for the admin password, in the existing Secret | string | `"admin-password"` |
| postgresql.auth.secretKeys.replicationPasswordKey | The key in which Postgres will look for, for the replication password, in the existing Secret | string | `"replication-password"` |
| postgresql.auth.secretKeys.userPasswordKey | The key in which Postgres will look for, for the user password, in the existing Secret | string | `"user-password"` |
| postgresql.auth.username | Name for a custom user to create | string | `"bn_backstage"` |
| postgresql.enabled | Switch to enable or disable the PostgreSQL helm chart | bool | `false` |
| service | Service parameters | object | See below |
| service.annotations | Additional custom annotations for Backstage service | object | `{}` |
| service.clusterIP | Backstage service Cluster IP  <br /> E.g `clusterIP: None` | string | `""` |
| service.externalTrafficPolicy | Backstage service external traffic policy  Ref: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip | string | `"Cluster"` |
| service.extraPorts | Extra ports to expose in the Backstage service (normally used with the `sidecar` value) | list | `[]` |
| service.loadBalancerIP | Backstage service Load Balancer IP  <br /> Ref: https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer | string | `""` |
| service.loadBalancerSourceRanges | Load Balancer sources  <br /> Ref: https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer <br /> E.g `loadBalancerSourceRanges: [10.10.10.0/24]` | list | `[]` |
| service.nodePorts | Node port for the Backstage client connections Choose port between `30000-32767` | object | `{"backend":""}` |
| service.ports | Backstage svc port for client connections | object | `{"backend":7007,"name":"http-backend","targetPort":"backend"}` |
| service.ports.name | Backstage svc port name | string | `"http-backend"` |
| service.ports.targetPort | Backstage svc target port referencing receiving pod container port | string | `"backend"` |
| service.sessionAffinity | Control where client requests go, to the same pod or round-robin (values: `ClientIP` or `None`) <br /> Ref: https://kubernetes.io/docs/concepts/services-networking/service/#session-stickiness | string | `"None"` |
| service.type | Kubernetes Service type | string | `"ClusterIP"` |
| serviceAccount | Service Account Configuration | object | See below |
| serviceAccount.annotations | Additional custom annotations for the ServiceAccount. | object | `{}` |
| serviceAccount.automountServiceAccountToken | Auto-mount the service account token in the pod | bool | `true` |
| serviceAccount.create | Enable the creation of a ServiceAccount for Backstage pods | bool | `false` |
| serviceAccount.labels | Additional custom labels to the service ServiceAccount. | object | `{}` |
| serviceAccount.name | Name of the ServiceAccount to use If not set and `serviceAccount.create` is true, a name is generated | string | `""` |

## Configure your Backstage instance

The Backstage Chart makes it possible to configure your backstage instance by passing extra environment variables or static configuration files, without rebuilding the docker image.

### Environment variables

Use `backstage.extraEnvVars` to pass extra environment variables. **This is used for environment variables containing non sensitive information:**

```diff
  backstage:
+   extraEnvVars:
+     - name: MY_PLUGIN_HOST
+       value: http://my-plugin-host
```

It is possible to override values defined in your `app-config.yaml` by appending the `APP_CONFIG` prefix to each environment variable, as described in the [official documentation](https://backstage.io/docs/conf/#supplying-configuration).
For example, to override the `backend.cache.store` property defined in your `app-config.yaml`, do:

```diff
  backstage:
    extraEnvVars:
+     - name: APP_CONFIG_backend_cache_store
+       value: memory
```

### Sensitive environment variables

In case your environment variables contain sensitive information, such as `BACKEND_SECRET` or `POSTGRES_PASSWORD` it is recommended store them in a [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/).

Create a new file named `my-backstage-secrets.yaml` containing the secrets you want to store:

```yaml
# my-backstage-secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-backstage-secrets
type: Opaque
data:
  BACKEND_SECRET: YmFja3N0YWdl
  POSTGRES_PASSWORD: aHVudGVyMg==
```

Make sure to customize the name of the secret by changing `metadata.name` properly.

Now create the new secret in your Kubernetes cluster by running the following command:

```bash
$ kubectl apply -f my-backstage-secrets.yaml`
```

Once the secret has been created, pass the secret's reference to your backstage instance by adding the following lines to your `values.yaml`:

```diff
  backstage:
+   extraEnvVarsSecrets:
+     - my-backstage-secrets
```

The chart will make sure to pass the secrets to your Backstage instance.

### Pass extra configuration files

A generated Backstage docker image contains some static configuration files, such as `app-config.yaml` and `app-config.production.yaml`.
It is possible to pass extra configuration files by defining them as [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), without rebuilding the Docker image.

To do so, run:

```bash
$ kubectl create configmap my-app-config --from-file=app-config.extra.yaml=./local/path/to/your/app-config.extra.yaml`
```

This command parses your local `app-config.extra.yaml` and creates a new ConfigMap called `my-app-config` which internally contains a file called `app-config.extra.yaml` with the content of the parsed file.

Now that the ConfigMap has been created on your Kubernetes cluster, you can reference the ConfigMap:

```diff
  backstage:
+   extraAppConfig:
+     - filename: app-config.extra.yaml
+       configMapRef: my-app-config
```

The chart will mount the content of the ConfigMap as a new `app-config.extra.yaml` file and automatically pass the extra configuration to your instance.

### Pass configuration to be stored in a ConfigMap

> :warning: In case of using both appConfig and extraAppConfig, appConfig will have higher priority over extraAppConfig. For more information you can check the [Backstage docs](https://backstage.io/docs/conf/writing#configuration-files) and how this [Helm Chart configures the Backstage arguments](templates/backstage-deployment.yaml)

In addition to following the [previous step "Pass extra configuration files"](#pass-extra-configuration-files), you can get the Config Map automatically deployed with this Helm Chart by defining the key `appConfig`:

```diff
  backstage:
+   appConfig:
+     app:
+       baseUrl: https://somedomain.tld
```

The chart will mount the content of the ConfigMap as a new `app-config-from-configmap.yaml` file and automatically pass the extra configuration to your instance.

### Configuring Chart PostgreSQL

With the Backstage Helm Chart, it offers - as a subchart - a Bitnami PostgreSQL database. This can be enabled by switching `postgresql.enabled` to true (it is `false` by default). If switched on, the Helm Chart, on deployment, will automatically deploy a PostgreSQL instance and configure it with the credentials you specify. There are multiple ways of doing this that will be detailed below.

#### Automatic Database Credential Creation

This is the easiest of the configuration options. Here, the credentials for both the Admin and Database users will be automatically generated and put into a Kubernetes secret. This will then be automatically used by Backstage. In order to use this method, ensure the following:

- Keep `postgresql.auth.existingSecret` & `postgresql.auth.password` empty.

#### Specifying Password for PostgreSQL to Use

Here, you can specify the password that you want PostgreSQL to use for its Database User (The user that Backstage will use to connect to the database). In order to use this method, ensure the following:

- Keep `postgresql.auth.existingSecret` empty.
- Set `postgresql.auth.password` to your desired User password value.

> **_NOTE:_** Be careful that you provide this value securely.

#### Specifying Existing Secret for PostgreSQL to Use

Here, you can specify an existing Kubernetes secret that you have created which contains the Password that you want PostgreSQL to use. The secret must be in the same namespace as where you are deploying the Helm Chart. In order to use this method, ensure the following:

- Create the Kubernetes secret with the Password inside.
- Set `postgresql.auth.existingSecret` to the name of the Secret
- PostgreSQL by default will look for the relevant Password keys that are set by default here `postgresql.auth.secretKeys`. So make sure that the Keys in the Secret match the default `secretKeys` values. More information [here](https://artifacthub.io/packages/helm/bitnami/postgresql)
- For example, if you want PostgreSQL to use an existing Secret called `my-user-secret` that has the User password that you want to use inside it: make sure that you create a Key inside that secret called `user-password` (this key can be found here `postgresql.auth.secretKeys.userPasswordKey`). i.e. `user-password=Password123`.
