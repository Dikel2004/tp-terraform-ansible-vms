# TP Terraform + Ansible - 2 VMs Linux

Ce projet cree une petite infrastructure avec Terraform, puis configure les machines avec Ansible.

Objectif :

- 1 VM `web` avec Nginx
- 1 VM `db` avec MariaDB
- les 2 VMs dans le meme reseau
- un utilisateur Linux `deploy`
- une page Nginx qui affiche l'adresse IP de la base de donnees
- un playbook Ansible relancable sans erreur
- une structure simple pour lancer `staging` ou `production` sans dupliquer le code

## Version Docker Desktop sur Windows

Si tu travailles sur Windows avec Docker Desktop, utilise cette version pour lancer rapidement le TP en local.

Elle simule la meme architecture avec des conteneurs :

- 1 conteneur `tp-web` avec Nginx ;
- 1 conteneur `tp-db` avec MariaDB ;
- 1 reseau Docker commun ;
- une page Nginx qui affiche l'adresse IP du conteneur DB.

Lancer :

```bash
docker compose up -d
```

Verifier :

```bash
docker compose ps
```

Ouvrir la page :

```text
http://localhost:8080
```

Arreter :

```bash
docker compose down
```

Supprimer aussi les donnees MariaDB :

```bash
docker compose down -v
```

Important : la version Docker est faite pour travailler facilement avec Docker Desktop. La version Terraform/Ansible garde la logique demandee dans le sujet avec des VMs.

## Schema simple du flux

```text
Utilisateur
   |
   v
Terraform
   |
   |-- cree le reseau commun
   |-- cree la VM web
   |-- cree la VM db
   |-- genere inventory.ini pour Ansible
   v
Ansible
   |
   |-- cree l'utilisateur deploy
   |-- installe Nginx sur web
   |-- installe MariaDB sur db
   |-- cree la page web avec l'IP de la DB
   v
Page Nginx accessible sur la VM web
```

## Structure

```text
.
|-- ansible/
|   |-- group_vars/
|   |   |-- all.yml
|   |   `-- environment.yml  # genere par Terraform
|   |-- requirements.yml
|   |-- roles/
|   |   |-- common/
|   |   |-- web/
|   |   `-- db/
|   |-- inventory.ini.example
|   `-- playbook.yml
|-- terraform/
|   |-- envs/
|   |   |-- production.tfvars
|   |   `-- staging.tfvars
|   |-- templates/
|   |   `-- inventory.ini.tftpl
|   |-- main.tf
|   |-- outputs.tf
|   |-- providers.tf
|   `-- variables.tf
|-- docs/
|   |-- checklist.md
|   `-- soutenance.md
|-- docker/
|   |-- db/
|   |   `-- backup.sh
|   `-- web/
|       `-- index.html.template
|-- docker-compose.yml
`-- logs/
    `-- second-run-example.log
```

## Ce que fait Terraform

Terraform declare l'infrastructure :

- un reseau commun ;
- deux VMs Linux ;
- une IP pour chaque VM ;
- un fichier `ansible/inventory.ini` genere automatiquement.

Le provider utilise ici est `libvirt`, car il permet de creer des VMs locales proprement sans scripts bash caches.

Terraform genere aussi deux fichiers pour Ansible :

- `ansible/inventory.ini` avec les IPs des VMs ;
- `ansible/group_vars/environment.yml` avec les variables `allowed_ports` et `enable_https`.

## Ce que fait Ansible

Ansible configure les VMs :

- role `common` : cree l'utilisateur `deploy` et installe les outils de base ;
- role `web` : installe et demarre Nginx, puis publie une page HTML ;
- role `db` : installe et demarre MariaDB, puis ajoute un cron de sauvegarde.
- pare-feu : seuls les ports declares dans Terraform sont ouverts.

Les taches sont idempotentes : relancer le playbook ne casse rien et ne duplique pas la configuration.

## Lancer en staging

```bash
cd terraform
terraform init
terraform apply -var-file="envs/staging.tfvars"

cd ../ansible
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory.ini playbook.yml
```

## Lancer en production

```bash
cd terraform
terraform init
terraform apply -var-file="envs/production.tfvars"

cd ../ansible
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory.ini playbook.yml
```

## Detruire l'infrastructure

```bash
cd terraform
terraform destroy -var-file="envs/staging.tfvars"
```

ou :

```bash
cd terraform
terraform destroy -var-file="envs/production.tfvars"
```

## Verification attendue

Apres Ansible :

```bash
curl http://IP_DE_LA_VM_WEB
```

La page doit afficher un message avec l'adresse IP de la VM DB.

## Securite

En production, les ports ouverts sont limites a SSH, HTTP et HTTPS. La variable `allowed_ports` se trouve dans :

- `terraform/envs/staging.tfvars`
- `terraform/envs/production.tfvars`

Le HTTPS est active en production avec un certificat local auto-signe pour le TP. Pour un vrai deploiement, il faudra remplacer ce certificat par un certificat officiel lie a un nom de domaine.

## Idempotence

Un exemple de deuxieme execution propre est donne dans :

```text
logs/second-run-example.log
```

Cela montre qu'Ansible peut etre relance sans erreur.
