# Support oral rapide

## Idee generale

Le projet separe clairement deux roles :

- Terraform construit l'infrastructure.
- Ansible configure les serveurs.

Terraform ne configure pas Nginx ou MariaDB. Il cree seulement les VMs, le reseau et les fichiers utiles pour Ansible.

## Si je presente avec Docker Desktop

Sur mon PC Windows, je peux montrer une version locale avec Docker Desktop.

Dans ce cas, je garde la meme logique :

- un service `web` avec Nginx ;
- un service `db` avec MariaDB ;
- un reseau Docker commun ;
- une page web qui affiche l'adresse IP de la base.

Je lance avec :

```bash
docker compose up -d
```

Puis j'ouvre :

```text
http://localhost:8080
```

Je precise au prof que Docker sert ici a faire une demonstration locale sur Windows. La logique du sujet Terraform/Ansible reste presente dans les dossiers `terraform/` et `ansible/`.

## Explication du flux

1. Je lance Terraform avec un fichier de variables, par exemple `staging.tfvars`.
2. Terraform cree une VM web, une VM db et un reseau commun.
3. Terraform recupere les IPs et genere `ansible/inventory.ini`.
4. Je lance Ansible.
5. Ansible installe Nginx sur la VM web et MariaDB sur la VM db.
6. La page Nginx affiche l'adresse IP de la VM db grace aux variables Ansible.

## Pourquoi les roles Ansible

J'ai separe les responsabilites :

- `common` : configuration commune, utilisateur `deploy`, paquets utiles, pare-feu.
- `web` : uniquement Nginx et la page HTML.
- `db` : uniquement MariaDB et la sauvegarde.

Cette separation rend le code plus lisible et plus facile a expliquer.

## Idempotence

Le playbook est relancable parce que les modules Ansible declarent un etat attendu :

- paquet present ;
- service demarre ;
- fichier avec un contenu precis ;
- cron present.

Donc une deuxieme execution ne refait pas tout inutilement.

## Production et staging

Je ne duplique pas le code.

Le meme Terraform est utilise pour les deux environnements. Seuls les fichiers de variables changent :

- `staging.tfvars`
- `production.tfvars`

En production, les VMs ont plus de ressources, HTTPS est active et le port 443 est autorise.

## Securite

Le pare-feu est configure avec UFW.

Les ports ouverts viennent de Terraform :

- staging : SSH et HTTP ;
- production : SSH, HTTP et HTTPS.

Pour le TP, le certificat HTTPS est auto-signe. En vrai projet, il faudrait un certificat officiel avec un nom de domaine.
