# prom-alert-routing-example

Example for routing Prometheus alerts to different receivers in multi-tenant
Kubernetes clusters using Alertmanager and VictorOps.

Read more about it in our [tech-blog](https://www.bonial.com/tech-blog/routing-prometheus-alerts-in-multi-tenant-kubernetes-clusters/).

## Prerequisites

The demo makes a couple of assumptions which need to be fulfilled before
applying it:

- Kubectl is installed
- Helm 3 is installed
- Your currently selected kube context points to a **non-production** cluster
  (run `kubectl config current-context` if you are unsure or use
  [kubectx](https://github.com/ahmetb/kubectx) to switch)

## Deploying the demo

Add helm repos for prometheus-operator:

```bash
$ make helm-repo
```

Create namespace:

```
$ kubectl create namespace par-demo
```

Export VictorOps API key and deploy prometheus-operator:

```bash
$ export VICTOROPS_API_KEY="<your-victorops-api-key>"
$ make deploy
```

## Playing around

You can expose Prometheus and Alertmanager at `localhost:9090` and
`localhost:9093` via port forwarding:

```bash
$ make prometheus-port-forward
$ make alertmanager-port-forward
```

The alerting rule (see [`deploy/values.yaml`](deploy/values.yaml)) used in this
example is relatively stupid: It will fire once the label `team` is added to a
pod. The value of this label will be used as the VictorOps routing key where
the alert will be sent to.

You can try it out by adding the label to the Prometheus pod itself:

```bash
$ kubectl label -n par-demo pod/prometheus-par-demo-kube-prometheus-s-prometheus-0 team=<your-victorops-routing-key>
```

Shortly after an alert is sent to VictorOps.

To stop the alert from firing, simply remove the label.

```bash
$ kubectl label -n par-demo pod/prometheus-par-demo-kube-prometheus-s-prometheus-0 team-
```

## Cleanup

Uninstall prometheus-operator:

```bash
$ make clean
```

Delete namespace:

```bash
$ kubectl delete namespace par-demo
```
