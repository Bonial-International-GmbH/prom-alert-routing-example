# prom-alert-routing-example

Example for routing prometheus alerts to different receivers in multi-tenant
Kubernetes clusters using Alertmanager and VictorOps.

# Prerequisites

The demo makes a couple of assumptions which need to be fulfilled before
applying it:

- Kubectl is installed (if you got here, you probably have it, right?)
- Helm 3 is installed (version 2.x will NOT work)
- Your currently selected kube context points to a *non*-production cluster
  (run `kubectl config current-context` if you are unsure or use
  [kubectx](https://github.com/ahmetb/kubectx) to switch)
- Your cluster has a `par-demo` namespace. This is not automatically created
  for you to prevent accidental deployment of the demo resources. You can
  create it via `kubectl create namespace par-demo`.
