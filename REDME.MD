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