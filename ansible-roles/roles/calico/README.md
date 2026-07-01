calico
=========

Instalacja calico (zarzadzanie siecią klastra kubernetesa)

Requirements
------------


Role Variables
--------------

---
# defaults file for ./roles/calico
calico_manifest_url: "https://raw.githubusercontent.com/projectcalico/calico/v3.28.2/manifests/calico.yaml"


Example Playbook
----------------
Instalacja z poziomu mastera.
Sprawdzenie:
sudo kubectl --kubeconfig /etc/kubernetes/admin.conf get pods -n kube-system
sudo kubectl --kubeconfig /etc/kubernetes/admin.conf get nodes #- status REDY
