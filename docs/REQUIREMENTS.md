# Pokrycie wymagań projektu

| Wymaganie | Realizacja w repozytorium | Status |
|---|---|---|
| Wybór publicznego repozytorium lub aplikacji | Prosta aplikacja `hello-web` w katalogu `app/` | Spełnione |
| Fork/kopia kodu | Kod aplikacji znajduje się w repozytorium projektu | Spełnione |
| IaC | Terraform w katalogu `terraform/` tworzy VM dla klastra i monitoringu | Spełnione |
| Automatyzacja konfiguracji | Ansible w `ansible-roles/` instaluje Kubernetes i komponenty | Spełnione |
| CI/CD | GitHub Actions: build, push do GHCR, deploy do Kubernetes | Spełnione |
| Monitoring infrastruktury | node-exporter, Prometheus, Grafana | Spełnione |
| Monitoring aplikacji/Kubernetes | kube-state-metrics, Prometheus targets, dashboardy Grafana | Spełnione częściowo — warto dodać metryki aplikacyjne lub dashboard Kubernetes |
| Logowanie | EFK: Elasticsearch, Fluent Bit, Kibana | Spełnione częściowo — opisać zakres zbierania logów |
| Dokumentacja | README + dokumenty w `docs/` | Do dodania |
| Bezpieczeństwo sekretów | `.gitignore` ignoruje tfvars/tfstate, ale pliki stanu i tfvars są już widoczne w repo | Wymaga poprawy historii Git |

## Najważniejsze braki do uzupełnienia

1. Zmienić `REDME.MD` na standardowy `README.md` i rozbudować dokumentację.
2. Usunąć z repozytorium `terraform.tfvars`, `terraform.tfstate`, `terraform.tfstate.backup` i `.venv`.
3. Dodać `terraform/terraform.tfvars.example` bez sekretów.
4. Dodać dokumentację architektury i procedur operacyjnych.
5. Uporządkować `site.yml`, bo rola `observability` występuje dwa razy — instalacja stacku i import dashboardów powinny być rozdzielone nazwami albo tagami.
6. Dodać readiness/liveness probes oraz resource requests/limits w manifestach Kubernetes.
