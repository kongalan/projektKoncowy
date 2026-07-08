# Architektura rozwiązania

## Warstwy

1. **Proxmox** — warstwa wirtualizacji.
2. **Terraform** — tworzy VM:
   - `k8s-master` — control-plane,
   - `k8s-worker1`, `k8s-worker2` — worker nodes,
   - `monitoring` / `monitoring-vm` — Prometheus, Grafana, EFK i eksportery.
3. **Ansible** — instaluje i konfiguruje systemy, containerd, Kubernetes, CNI, ingress, eksportery i monitoring.
4. **Kubernetes** — uruchamia aplikację `hello-web`.
5. **GitHub Actions** — automatyzuje build, publikację obrazu i deployment.
6. **Observability** — Prometheus zbiera metryki, Grafana prezentuje dashboardy, EFK obsługuje logi.

## Przepływ CI/CD

```text
push do master
    ↓
GitHub Actions self-hosted runner
    ↓
docker build ./app
    ↓
push obrazu do GHCR
    ↓
kubectl apply -f kubernetes/
    ↓
kubectl set image deployment/hello-web
    ↓
kubectl rollout status
```

## Przepływ infrastruktury

```text
workflow_dispatch infra-k8s.yml lub ręczne terraform apply
    ↓
Terraform tworzy VM w Proxmox
    ↓
Ansible konfiguruje VM
    ↓
kubeadm init + join workerów
    ↓
Calico + ingress-nginx + monitoring
```
