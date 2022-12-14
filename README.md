# Backstage Helm Chart

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

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

## Backstage Chart

More information can be found by inspecting the [backstage chart](charts/backstage).
