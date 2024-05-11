# Contributing to Backstage Charts

Before making a contribution to the [Backstage Helm Chart](https://github.com/backstage/charts) you will need to ensure the following steps have been done:
- [Sign your commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)
- Run `helm template` on the changes you're making to ensure they are correctly rendered into Kubernetes manifests.
- Lint tests has been run for the Chart using the [Chart Testing](https://github.com/helm/chart-testing) tool and the `ct lint` command.
- Ensure variables are documented in `values.yaml` and the [pre-commit](https://pre-commit.com/) hook has been run with `pre-commit run --all-files` to generate the `README.md` documentation. To preview the content, use `helm-docs --dry-run`.
- If you are making changes to the Chart - remember to bump the Chart version following [SemVer](https://semver.org/). You will need to change the [Chart Version](https://github.com/backstage/charts/blob/main/charts/backstage/Chart.yaml#L41) and the [Chart Badge](https://github.com/backstage/charts/blob/main/charts/backstage/README.md?plain=1#L5) on the README.
