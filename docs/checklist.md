# Checklist des exigences

## Niveau 1 - Novice

- Terraform cree 2 VMs Linux : `terraform/main.tf`
- VMs dans un reseau commun : `libvirt_network.private`
- `apply` et `destroy` possibles : commandes dans `README.md`
- Utilisateur `deploy` : `ansible/roles/common/tasks/main.yml`
- Nginx sur la VM web : `ansible/roles/web/tasks/main.yml`
- MariaDB sur la VM db : `ansible/roles/db/tasks/main.yml`
- Services actifs : taches `service` dans les roles `web` et `db`
- Playbook relancable : modules Ansible idempotents + `logs/second-run-example.log`

## Niveau 2 - Engineer

- Fichiers Terraform structures : dossier `terraform/`
- Variables claires : `terraform/variables.tf`
- Environnements separes : `terraform/envs/staging.tfvars` et `terraform/envs/production.tfvars`
- Outputs Terraform : `terraform/outputs.tf`
- Inventory Ansible genere par Terraform : `terraform/templates/inventory.ini.tftpl`
- Roles Ansible : `common`, `web`, `db`
- Page Nginx avec IP de la DB : `ansible/roles/web/templates/index.html.j2`

## Niveau 3 - Architect

- Production et staging sans duplication : memes fichiers Terraform, seuls les `.tfvars` changent
- Restriction des ports en production : `allowed_ports` dans `production.tfvars`
- HTTPS en production : `enable_https = true` dans `production.tfvars`
- Cron de sauvegarde MariaDB : `ansible/roles/db/tasks/main.yml`
- Logs d'idempotence : `logs/second-run-example.log`

## Rendu

- Branche Git locale : `main`
- README explicatif : `README.md`
- Schema du flux : section `Schema simple du flux`
- Support oral : `docs/soutenance.md`

## Demo Docker Desktop

- Compose avec 2 conteneurs : `docker-compose.yml`
- Nginx sur le conteneur web : service `web`
- MariaDB sur le conteneur db : service `db`
- Reseau commun : `tp_network`
- Page affichant l'IP de la DB : `docker/web/index.html.template`
