# Checklist niveau 1

## Terraform

- 2 VMs Linux prevues : `web` et `db`
- Reseau commun : `libvirt_network.private`
- `terraform apply` possible
- `terraform destroy` possible
- Inventory Ansible genere : `ansible/inventory.ini`

## Ansible

- Utilisateur `deploy` : role `common`
- Nginx sur web : role `web`
- MariaDB sur db : role `db`
- Services actives : taches `service`
- Playbook relancable : modules Ansible idempotents

## Demo Docker Desktop

- Conteneur web : `tp-web`
- Conteneur db : `tp-db`
- Reseau commun : `tp_network`
- Page accessible : `http://localhost:8080`
- Page avec IP MariaDB : `docker/web/index.html.template`

## Interdictions

- Pas de modification manuelle des VMs
- Pas de script bash pour configurer les serveurs
