# Backstage Helm Chart

![Version: 0.20.0](https://img.shields.io/badge/Version-0.20.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for deploying a Backstage application

---

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

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

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 1.x.x |
| https://charts.bitnami.com/bitnami | postgresql | 11.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backstage | object | See below | Backstage parameters |
| backstage.appConfig | object | `{}` | Generates ConfigMap and configures it in the Backstage pods |
| backstage.args | list | `[]` | Backstage container command arguments |
| backstage.command | list | `["node","packages/backend"]` | Backstage container command |
| backstage.containerPorts | object | `{"backend":7007}` | Container ports on the Deployment |
| backstage.containerSecurityContext | object | `{}` | Security settings for a Container. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container |
| backstage.extraAppConfig | list | `[]` | Extra app configuration files to inline into command arguments |
| backstage.extraContainers | list | `[]` | Deployment sidecars |
| backstage.extraEnvVars | list | `[]` | Backstage container environment variables |
| backstage.extraEnvVarsSecrets | list | `[]` | Backstage container environment variables from Secrets |
| backstage.extraVolumeMounts | list | `[]` | Backstage container additional volume mounts |
| backstage.extraVolumes | list | `[]` | Backstage container additional volumes |
| backstage.image.debug | bool | `false` | Set to true if you would like to see extra information on logs |
| backstage.image.pullPolicy | string | `"Always"` | Specify a imagePullPolicy. Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' <br /> Ref: https://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| backstage.image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets.  Secrets must be manually created in the namespace. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ <br /> E.g: `pullSecrets: [myRegistryKeySecretName]` |
| backstage.image.registry | string | `"ghcr.io"` | Backstage image registry |
| backstage.image.repository | string | `"backstage/backstage"` | Backstage image repository |
| backstage.image.tag | string | `"latest"` | Backstage image tag (immutable tags are recommended) |
| backstage.initContainers | list | `[]` | Backstage container init containers |
| backstage.installDir | string | `"/app"` | Directory containing the backstage installation |
| backstage.nodeSelector | object | `{}` | Node labels for pod assignment <br /> Ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| backstage.podAnnotations | object | `{}` | Annotations to add to the backend deployment pods |
| backstage.podSecurityContext | object | `{}` | Security settings for a Pod.  The security settings that you specify for a Pod apply to all Containers in the Pod. <br /> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod |
| backstage.replicas | int | `1` | Number of deployment replicas |
| backstage.resources | object | `{}` | Resource requests/limits <br /> Ref: https://kubernetes.io/docs/user-guide/compute-resources/ <!-- E.g. resources:   limits:     memory: 1Gi     cpu: 1000m   requests:     memory: 250Mi     cpu: 100m --> |
| backstage.tolerations | list | `[]` | Node tolerations for server scheduling to nodes with taints <br /> Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ |
| clusterDomain | string | `"cluster.local"` | Default Kubernetes cluster domain |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| diagnosticMode | object | `{"args":["infinity"],"command":["sleep"],"enabled":false}` | Enable diagnostic mode in the Deployment |
| diagnosticMode.args | list | `["infinity"]` | Args to override all containers in the Deployment |
| diagnosticMode.command | list | `["sleep"]` | Command to override all containers in the Deployment |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled and the command will be overridden) |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| global | object | See below | Global parameters Global Docker image parameters Please, note that this will override the image parameters, including dependencies, configured to use the global value Current available global Docker image parameters: imageRegistry, imagePullSecrets and storageClass |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array </br> E.g. `imagePullSecrets: [myRegistryKeySecretName]` |
| global.imageRegistry | string | `""` | Global Docker image registry |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"host":"","tls":{"enabled":false,"secretName":""}}` | Ingress parameters |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource |
| ingress.className | string | `""` | Name of the IngressClass cluster resource which defines which controller will implement the resource (e.g nginx) |
| ingress.enabled | bool | `false` | Enable the creation of the ingress resource |
| ingress.host | string | `""` | Hostname to be used to expose the route to access the backstage application (e.g: backstage.IP.nip.io) |
| ingress.tls | object | `{"enabled":false,"secretName":""}` | Ingress TLS parameters |
| ingress.tls.enabled | bool | `false` | Enable TLS configuration for the host defined at `ingress.host` parameter |
| ingress.tls.secretName | string | `""` | The name to which the TLS Secret will be called |
| kubeVersion | string | `""` | Override Kubernetes version |
| metrics | object | `{"serviceMonitor":{"annotations":{},"enabled":false,"interval":null,"labels":{},"path":"/metrics"}}` | Metrics configuration |
| metrics.serviceMonitor | object | `{"annotations":{},"enabled":false,"interval":null,"labels":{},"path":"/metrics"}` | ServiceMonitor configuration <br /> Allows configuring your backstage instance as a scrape target for [Prometheus](https://github.com/prometheus/prometheus) using a ServiceMonitor custom resource that [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) can understand. |
| metrics.serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| metrics.serviceMonitor.enabled | bool | `false` | If enabled, a ServiceMonitor resource for Prometheus Operator is created <br /> Prometheus Operator must be installed in your cluster prior to enabling. |
| metrics.serviceMonitor.interval | string | `nil` | ServiceMonitor scrape interval |
| metrics.serviceMonitor.labels | object | `{}` | Additional ServiceMonitor labels |
| metrics.serviceMonitor.path | string | `"/metrics"` | ServiceMonitor endpoint path <br /> Note that the /metrics endpoint is NOT present in a freshly scaffolded Backstage app. To setup, follow the [Prometheus metrics tutorial](https://github.com/backstage/backstage/blob/master/contrib/docs/tutorials/prometheus-metrics.md). |
| nameOverride | string | `""` | String to partially override common.names.fullname |
| networkPolicy | object | `{"egressRules":{"customRules":[]},"enabled":false,"externalAccess":{"from":[]}}` | Network policies <br /> Ref: https://kubernetes.io/docs/concepts/services-networking/network-policies/ |
| networkPolicy.egressRules | object | `{"customRules":[]}` | Custom network policy rule |
| networkPolicy.egressRules.customRules | list | `[]` | Additional custom egress rules e.g: customRules:   - to:       - namespaceSelector:           matchLabels:             label: example |
| networkPolicy.enabled | bool | `false` | networkPolicy.enabled Specifies whether a NetworkPolicy should be created |
| postgresql | object | See below | PostgreSQL [chart configuration](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml) |
| postgresql.architecture | string | `"standalone"` | PostgreSQL architecture (`standalone` or `replication`) |
| postgresql.auth | object | `{"existingSecret":"","password":"","secretKeys":{"adminPasswordKey":"admin-password","replicationPasswordKey":"replication-password","userPasswordKey":"user-password"},"username":"bn_backstage"}` | The authentication details of the Postgres database |
| postgresql.auth.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| postgresql.auth.password | string | `""` | Password for the custom user to create |
| postgresql.auth.secretKeys | object | `{"adminPasswordKey":"admin-password","replicationPasswordKey":"replication-password","userPasswordKey":"user-password"}` | The secret keys Postgres will look for to retrieve the relevant password |
| postgresql.auth.secretKeys.adminPasswordKey | string | `"admin-password"` | The key in which Postgres will look for, for the admin password, in the existing Secret |
| postgresql.auth.secretKeys.replicationPasswordKey | string | `"replication-password"` | The key in which Postgres will look for, for the replication password, in the existing Secret |
| postgresql.auth.secretKeys.userPasswordKey | string | `"user-password"` | The key in which Postgres will look for, for the user password, in the existing Secret |
| postgresql.auth.username | string | `"bn_backstage"` | Name for a custom user to create |
| postgresql.enabled | bool | `false` | Switch to enable or disable the PostgreSQL helm chart |
| service | object | See below | Service parameters |
| service.annotations | object | `{}` | Additional custom annotations for Backstage service |
| service.clusterIP | string | `""` | Backstage service Cluster IP  <br /> E.g `clusterIP: None` |
| service.externalTrafficPolicy | string | `"Cluster"` | Backstage service external traffic policy  Ref: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| service.extraPorts | list | `[]` | Extra ports to expose in the Backstage service (normally used with the `sidecar` value) |
| service.loadBalancerIP | string | `""` | Backstage service Load Balancer IP  <br /> Ref: https://kubernetes.io/docs/user-guide/services/#type-loadbalancer |
| service.loadBalancerSourceRanges | list | `[]` | Load Balancer sources  <br /> Ref: https://kubernetes.io/docs/tasks/access-application-cluster/cnfigure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service <br /> E.g `loadBalancerSourceRanges: [10.10.10.0/24]` |
| service.nodePorts | object | `{"backend":""}` | Node port for the Backstage client connections Choose port between `30000-32767` |
| service.ports | object | `{"backend":7007,"name":"http-backend","targetPort":"backend"}` | Backstage svc port for client connections |
| service.ports.name | string | `"http-backend"` | Backstage svc port name |
| service.ports.targetPort | string | `"backend"` | Backstage svc target port referencing receiving pod container port |
| service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin (values: `ClientIP` or `None`) <br /> Ref: https://kubernetes.io/docs/user-guide/services/ |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| serviceAccount | object | See below | Service Account Configuration |
| serviceAccount.annotations | object | `{}` | Additional custom annotations for the ServiceAccount. |
| serviceAccount.automountServiceAccountToken | bool | `true` | Auto-mount the service account token in the pod |
| serviceAccount.create | bool | `false` | Enable the creation of a ServiceAccount for Backstage pods |
| serviceAccount.labels | object | `{}` | Additional custom labels to the service ServiceAccount. |
| serviceAccount.name | string | `""` | Name of the ServiceAccount to use If not set and `serviceAccount.create` is true, a name is generated |

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
