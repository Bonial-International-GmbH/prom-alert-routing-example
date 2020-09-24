Label Pod with team label:

  $ kubectl label pod/prometheus-par-demo-kube-prometheus-stack-prometheus-0 team=ops
  $ make prometheus-port-forward

Web:

  http://localhost:9090/graph?g0.range_input=1h&g0.expr=kube_pod_labels%7Bpod%3D%22prometheus-demo-kube-prometheus-stack-prometheus-0%22%7D&g0.tab=1

PromQL:

  kube_pod_labels{pod="prometheus-demo-kube-prometheus-stack-prometheus-0"}

Observe label_team:

  kube_pod_labels{endpoint="http",instance="10.0.57.244:8080",job="kube-state-metrics",label_app="prometheus",label_controller_revision_hash="prometheus-demo-kube-prometheus-stack-prometheus-59fdcf5d58",label_prometheus="demo-kube-prometheus-stack-prometheus",label_statefulset_kubernetes_io_pod_name="prometheus-demo-kube-prometheus-stack-prometheus-0",label_team="ops",namespace="demo",pod="prometheus-demo-kube-prometheus-stack-prometheus-0",service="demo-kube-state-metrics"}
