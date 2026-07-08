# Procedury operacyjne

## Sprawdzenie klastra

```bash
kubectl get nodes -o wide
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```

## Sprawdzenie aplikacji

```bash
kubectl get deployment hello-web
kubectl rollout status deployment/hello-web
kubectl get pods -l app=hello-web -o wide
curl -H 'Host: hello.local' http://<IP_INGRESS>/
```

## Sprawdzenie Prometheusa

```bash
curl http://192.168.137.13:9090/-/ready
curl http://192.168.137.13:9090/api/v1/targets
```

## Sprawdzenie node-exporter

```bash
curl http://192.168.137.10:9100/metrics | head
curl http://192.168.137.11:9100/metrics | head
curl http://192.168.137.12:9100/metrics | head
curl http://192.168.137.13:9100/metrics | head
```

## Typowe naprawy

### Deployment nie przechodzi

```bash
kubectl describe pod -l app=hello-web
kubectl logs -l app=hello-web --tail=100
kubectl rollout undo deployment/hello-web
```

### Prometheus nie widzi targetów

1. Sprawdź, czy exporter działa na VM.
2. Sprawdź firewall i routing między monitoring VM a node'ami.
3. Sprawdź plik `prometheus.yml` generowany z template Ansible.

### Terraform chce odtworzyć istniejącą VM

1. Sprawdź stan:

```bash
terraform state list
terraform state show 'proxmox_virtual_environment_vm.k8s["monitoring"]'
```

2. Jeśli VM istnieje poza stanem, zaimportuj ją zamiast tworzyć od nowa.
3. Nie usuwaj ręcznie plików lock/state bez backupu.
