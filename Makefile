.DEFAULT_GOAL := help

NAMESPACE ?= par-demo
NAME ?= $(NAMESPACE)
VICTOROPS_API_KEY ?= REPLACEME

.PHONY: help deploy template clean prometheus-port-forward alertmanager-port-forward helm-repo

help:
	@grep -E '^[a-zA-Z0-9-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-23s[0m %s\n", $$1, $$2}'

all: helm-repo deploy

helm-repo: ## add helm repos
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	helm repo update

deploy: ## deploy the demo
	@helm upgrade $(NAME) prometheus-community/kube-prometheus-stack \
		--namespace $(NAMESPACE) --values deploy/values.yaml --install \
		--set alertmanager.config.global.victorops_api_key="$(VICTOROPS_API_KEY)"

template: ## render manifest for debugging
	@helm template $(NAME) prometheus-community/kube-prometheus-stack \
		--namespace $(NAMESPACE) --values deploy/values.yaml \
		--set alertmanager.config.global.victorops_api_key="$(VICTOROPS_API_KEY)"

clean: ## remove the demo resources
	helm uninstall $(NAME) --namespace $(NAMESPACE)

prometheus-port-forward: ## expose prometheus on localhost:9090
	kubectl port-forward --namespace $(NAMESPACE) svc/prometheus-operated 9090:9090

alertmanager-port-forward: ## expose alertmanager on localhost:9093
	kubectl port-forward --namespace $(NAMESPACE) svc/alertmanager-operated 9093:9093
