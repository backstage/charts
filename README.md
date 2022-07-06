# Backstage

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

## TL;DR

```console
helm repo add backstage https://vinzscam.github.io/backstage-chart
helm install my-release backstage
```

## Introduction

This chart bootstraps a [Backstage](https://backstage.io/docs/deployment/docker) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-backstage-release`:

```console
helm repo add backstage https://vinzscam.github.io/backstage-chart
helm install my-backstage-release backstage
```

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-backstage-release` deployment:

```console
helm delete my-backstage-release
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

### Backstage parameters

| Name                            | Description                                                          | Value                                                                       |
| ------------------------------- | -------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `backstage.image.registry`      | Backstage image registry                                             | `""`                                                                        |
| `backstage.image.repository`    | Backstage image repository                                           | `""`                                                                        |
| `backstage.image.tag`           | Backstage image tag (immutable tags are recommended)                 | `""`                                                                        |
| `backstage.image.pullPolicy`    | Backstage image pull policy                                          | `IfNotPresent`                                                              |
| `backstage.image.pullSecrets`   | Specify docker-registry secret names as an array                     | `[]`                                                                        |
| `backstage.command`             | Override Backstage container command                                 | `["node", "packages/backend"]`                                              |
| `backstage.args`                | Override Backstage container arguments                               | `["--config", "app-config.yaml", "--config", "app-config.production.yaml"]` |
| `backstage.extraEnvVars`        | Extra environment variables to add to Backstage pods                 | `[]`                                                                        |
| `backstage.extraAppConfig`      | ConfigMap with extra environment variables                           | `[]`                                                                        |
| `backstage.extraEnvVarsSecrets` | Array of existing secrets containing sensitive environment variables | `[]`                                                                        |

### Traffic Exposure parameters

| Name                               | Description                                                      | Value       |
|------------------------------------|------------------------------------------------------------------|-------------|
| `ingress.enabled`                  | Enable ingress                                                   | `false`     |
| `ingress.className`                | Name of the IngressClass cluster resource (e.g nginx)            | `""`        |
| `ingress.annotations`              | Additional annotations for the Ingress resource                  | `{}`        |
| `ingress.host`                     | Hostname of the backstage application (e.g backstage.<IP>.nip.io) | `""`        |
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
