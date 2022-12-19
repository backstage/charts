# Backstage Helm Chart

![Version: 0.10.0](https://img.shields.io/badge/Version-0.10.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

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
| backstage.args | list | `[]` |  |
| backstage.command[0] | string | `"node"` |  |
| backstage.command[1] | string | `"packages/backend"` |  |
| backstage.containerPorts.backend | int | `7007` |  |
| backstage.containerSecurityContext | object | `{}` |  |
| backstage.extraAppConfig[0].configMapRef | string | `"app-config"` |  |
| backstage.extraAppConfig[0].data | string | `"app:\n  title: Scaffolded Backstage App\n  baseUrl: http://localhost:3000\n\norganization:\n  name: localhost\n\nbackend:\n  baseUrl: http://localhost:7007\n  listen:\n    port: 7007\n  csp:\n    connect-src: [\"'self'\", 'http:', 'https:']\n    img-src: [\"'self'\", 'data:', 'https://avatars.githubusercontent.com']\n  cors:\n    origin: http://localhost:3000\n    methods: [GET, POST, PUT, DELETE]\n    credentials: true\n  database:\n    client: pg\n    connection:\n      host: ${POSTGRES_HOST}\n      port: ${POSTGRES_PORT}\n      user: ${POSTGRES_USER}\n      password: ${POSTGRES_PASSWORD}\n  cache:\n    store: memory\n\nintegrations:\n  github:\n    - host: github.com\n      token: ${GITHUB_TOKEN}\n\ntechdocs:\n  builder: 'local' # Alternatives - 'external'\n  generator:\n    runIn: 'local' # Alternatives - 'local or docker'\n  publisher:\n    type: 'local' # Alternatives - 'googleGcs' or 'awsS3'. Read documentation for using alternatives.\n\nauth:\n  environment: development\n  providers:\n    github:\n      development:\n        clientId: ${AUTH_GITHUB_CLIENT_ID}\n        clientSecret: ${AUTH_GITHUB_CLIENT_SECRET}\n"` |  |
| backstage.extraAppConfig[0].filename | string | `"app-config.yaml"` |  |
| backstage.extraAppConfig[1].configMapRef | string | `"app-config-production"` |  |
| backstage.extraAppConfig[1].data | string | `"app:\n  title: somedomain\n  baseUrl: https://platform.somedomain.ltd\n\nbackend:\n  baseUrl: https://platform.somedomain.ltd\n  listen:\n    port: 7007\n\n  csp:\n    connect-src: [\"'self'\", 'http:', 'https:']\n\n  cors:\n    origin: https://platform.somedomain.ltd\n  database:\n    client: pg\n    connection:\n      host: ${POSTGRES_HOST}\n      port: ${POSTGRES_PORT}\n      user: ${POSTGRES_USER}\n      password: ${POSTGRES_PASSWORD}\n\n  cache:\n    store: memory\n\nintegrations:\n  github:\n    - host: github.com\n      token: ${GITHUB_TOKEN}\n\ntechdocs:\n  builder: 'local' # Alternatives - 'external'\n  generator:\n    runIn: 'local' # Alternatives - 'local'\n  publisher:\n    type: 'local' # Alternatives - 'googleGcs' or 'awsS3'. Read documentation for using alternatives.\n\nauth:\n  environment: production\n  providers:\n    github:\n      production:\n        clientId: ${AUTH_GITHUB_CLIENT_ID}\n        clientSecret: ${AUTH_GITHUB_CLIENT_SECRET}\n        # enterpriseInstanceUrl: ${AUTH_GITHUB_ENTERPRISE_INSTANCE_URL}\n"` |  |
| backstage.extraAppConfig[1].filename | string | `"app-config.production.yaml"` |  |
| backstage.extraEnvVarsSecrets[0] | string | `"backstage-database-authentication"` |  |
| backstage.extraEnvVarsSecrets[1] | string | `"backstage-kubernetes-authentication"` |  |
| backstage.extraEnvVarsSecrets[2] | string | `"backstage-github-authentication"` |  |
| backstage.extraEnvVars[0].name | string | `"APP_CONFIG_backend_baseUrl"` |  |
| backstage.extraEnvVars[0].value | string | `"https://platform.polarpoint.io"` |  |
| backstage.extraEnvVars[1].name | string | `"APP_CONFIG_backend_origin"` |  |
| backstage.extraEnvVars[1].value | string | `"https://platform.polarpoint.io"` |  |
| backstage.extraEnvVars[2].name | string | `"APP_CONFIG_app_baseUrl"` |  |
| backstage.extraEnvVars[2].value | string | `"https://platform.polarpoint.io"` |  |
| backstage.extraEnvVars[3].name | string | `"POSTGRES_HOST"` |  |
| backstage.extraEnvVars[3].value | string | `"backstage-postgresql-non-prod"` |  |
| backstage.extraVolumeMounts | list | `[]` |  |
| backstage.extraVolumes | list | `[]` |  |
| backstage.image.debug | bool | `false` |  |
| backstage.image.pullPolicy | string | `"Always"` |  |
| backstage.image.pullSecrets | list | `[]` |  |
| backstage.image.registry | string | `"ghcr.io"` |  |
| backstage.image.repository | string | `"backstage/backstage"` |  |
| backstage.image.tag | string | `"latest"` |  |
| backstage.podSecurityContext | object | `{}` |  |
| clusterDomain | string | `"cluster.local"` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| extraDeploy | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.host | string | `""` |  |
| ingress.tls.enabled | bool | `false` |  |
| ingress.tls.secretName | string | `""` |  |
| kubeVersion | string | `""` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egressRules.customRules | list | `[]` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.externalAccess.from | list | `[]` |  |
| postgresql | object | `{"architecture":"standalone","auth":{"existingSecret":"","password":"","secretKeys":{"adminPasswordKey":"admin-password","replicationPasswordKey":"replication-password","userPasswordKey":"user-password"},"username":"bn_backstage"},"enabled":false}` | PostgreSQL [chart configuration](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml) |
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
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.extraPorts | list | `[]` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.backend | string | `""` |  |
| service.ports.backend | int | `7007` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount | object | `{"annotations":{},"automountServiceAccountToken":true,"create":false,"labels":{},"name":""}` | Service Account Configuration |
| serviceAccount.annotations | object | `{}` | Additional custom annotations for the ServiceAccount. |
| serviceAccount.automountServiceAccountToken | bool | `true` | Auto-mount the service account token in the pod |
| serviceAccount.create | bool | `false` | Enable the creation of a ServiceAccount for Backstage pods |
| serviceAccount.labels | object | `{}` | Additional custom labels to the service ServiceAccount. |
| serviceAccount.name | string | `""` | Name of the created ServiceAccount If not set and `serviceAccount.create` is true, a name is generated |

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
