dodano agenta ssh do ~/.bashrc w celu pomijania wielokrotnego wpisywania passphrase do klucza SSH

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

po ponownym logowaniu nalezy wykonać:
ssh-add ~/.ssh/id_rsa

uruchomienie terraforma:
terraform init
terraform plan
terraform apply

uruchomienie ansibla:
cd ansible-roles
ansible -i inventory.ini k8s -m ping
ansible-playbook -i inventory.ini site.yml

sprawzenie na masterze:
ssh ubuntu@192.168.137.10
kubectl get nodes
kubectl get pods -A


# projektKoncowy — DevOps end project

Projekt pokazuje pełny proces DevOps dla prostej aplikacji webowej wdrażanej na klaster Kubernetes uruchomiony na Proxmox.

## Zakres

- infrastruktura jako kod: Terraform tworzy maszyny VM w Proxmox,
- konfiguracja systemów i klastra: Ansible instaluje containerd, Kubernetes, Calico, ingress-nginx, node-exporter i monitoring,
- CI/CD: GitHub Actions buduje obraz Docker, publikuje go w GHCR i wdraża aplikację do Kubernetes,
- monitoring: Prometheus, Grafana, node-exporter, kube-state-metrics, Proxmox exporter oraz EFK,
- aplikacja testowa: `hello-web` oparta o Nginx.

## Struktura repozytorium

```text
.github/workflows/      Pipeline CI/CD oraz pipeline infrastruktury
app/                    Kod aplikacji i Dockerfile
kubernetes/             Manifesty Kubernetes aplikacji
terraform/              Definicje VM w Proxmox
ansible-roles/          Inventory, playbook site.yml oraz role Ansible
docs/                   Dokumentacja architektury, wymagań i operacji
```

## Wymagania wstępne

- Proxmox z przygotowanym template VM `9000` z cloud-init,
- token API Proxmox o uprawnieniach do tworzenia i modyfikacji VM,
- self-hosted runner GitHub Actions z dostępem do Proxmox i klastra,
- lokalny klucz SSH użytkownika `ubuntu`,
- Terraform, Ansible, kubectl i Docker na runnerze lub stacji administracyjnej.

## Sekrety GitHub Actions

Ustaw w repozytorium:

- `PM_API_URL`, np. `https://192.168.137.x:8006/api2/json`,
- `PM_TOKEN_ID`, np. `terraform@pve!terraform-token`,
- `PM_TOKEN_SECRET`,
- `SSH_PUBLIC_KEY`,
- opcjonalnie `KUBECONFIG_B64`, jeśli deployment nie działa bezpośrednio z master node.

Nie trzymaj w repozytorium plików `terraform.tfvars`, `terraform.tfstate`, `terraform.tfstate.backup`, `.terraform/` ani sekretów.

## Uruchomienie infrastruktury

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Konfiguracja klastra

```bash
cd ansible-roles
ansible -i inventory.ini k8s -m ping
ansible-playbook -i inventory.ini site.yml
```

## Deployment aplikacji

Deployment aplikacji wykonuje workflow `.github/workflows/deploy.yml` po pushu do gałęzi `master`.

Ręcznie:

```bash
kubectl apply -f kubernetes/
kubectl rollout status deployment/hello-web -n default
```

## Sprawdzenie działania

```bash
kubectl get nodes
kubectl get pods -A
kubectl get ingress
curl -H 'Host: hello.local' http://<IP_INGRESS_CONTROLLERA>/
```

## Monitoring

Po wykonaniu roli `observability` usługi są dostępne na VM `monitoring-vm`:

- Grafana: `http://192.168.137.13:3000`,
- Prometheus: `http://192.168.137.13:9090`,
- Kibana: `http://192.168.137.13:5601`.

Szczegóły są w `docs/OPERATIONS.md`.
