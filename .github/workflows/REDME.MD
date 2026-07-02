GitHub zaleca nadanie GITHUB_TOKEN uprawnień contents: read i packages: write do publikowania paczek/obrazów z Actions.

Sekret KUBECONFIG

Na masterze:

sudo cat /etc/kubernetes/admin.conf | base64 -w 0

Wynik dodaj w GitHub:

Settings → Secrets and variables → Actions → New repository secret

Nazwa sekretu:

KUBECONFIG
Ważne

Po pierwszym pushu obraz w GHCR może być prywatny. Najprościej ustaw go jako publiczny:

GitHub → profil → Packages → hello-web → Package settings → Change visibility → Public

Publiczne obrazy z GitHub Container Registry można pobierać anonimowo.

Potem:

git add .
git commit -m "add ghcr pipeline"
git push origin main

Strona:

http://hello.local