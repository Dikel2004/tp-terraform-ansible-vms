# TP Niveau 1 - Terraform, Ansible et Docker

Ce projet correspond au niveau 1 du sujet.

L'objectif est simple :

- creer 2 machines Linux : une machine `web` et une machine `db` ;
- mettre les deux machines dans le meme reseau ;
- installer Nginx sur `web` ;
- installer MariaDB sur `db` ;
- creer un utilisateur `deploy` ;
- avoir une page Nginx accessible ;
- pouvoir relancer le playbook Ansible sans erreur.

Comme je travaille sur Windows avec Docker Desktop, j'ai aussi ajoute une demo Docker simple pour montrer le fonctionnement en local.

## Demo Docker Desktop

La demo Docker lance :

- un conteneur `tp-web` avec Nginx ;
- un conteneur `tp-db` avec MariaDB ;
- un reseau Docker commun ;
- une page web qui affiche l'adresse IP du conteneur MariaDB.

Lancer :

```powershell
docker compose up -d
```

Verifier :

```powershell
docker compose ps
```

Ouvrir dans le navigateur :

```text
http://localhost:8080
```

Arreter :

```powershell
docker compose down
```

Supprimer aussi les donnees MariaDB :

```powershell
docker compose down -v
```

## Schema simple

```text
Utilisateur
   |
   v
Nginx web
   |
   v
MariaDB db
```

Avec Terraform et Ansible, le flux est :

```text
Terraform cree les VMs et le reseau
             |
             v
Terraform genere l'inventaire Ansible
             |
             v
Ansible configure web et db
```

## Structure du projet

```text
.
|-- ansible/
|   |-- group_vars/
|   |   `-- all.yml
|   |-- roles/
|   |   |-- common/
|   |   |-- web/
|   |   `-- db/
|   |-- inventory.ini.example
|   `-- playbook.yml
|-- docker/
|   `-- web/
|       `-- index.html.template
|-- docs/
|   |-- checklist.md
|   `-- soutenance.md
|-- logs/
|   `-- second-run-example.log
|-- terraform/
|   |-- templates/
|   |   `-- inventory.ini.tftpl
|   |-- main.tf
|   |-- outputs.tf
|   |-- providers.tf
|   |-- terraform.tfvars.example
|   `-- variables.tf
|-- docker-compose.yml
`-- README.md
```

## Ce que fait Terraform

Terraform sert a creer l'infrastructure :

- une VM `web` ;
- une VM `db` ;
- un reseau commun ;
- un fichier `ansible/inventory.ini` avec les adresses IP.

Commandes prevues sur un environnement Linux avec libvirt :

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

Pour detruire :

```bash
terraform destroy
```

## Ce que fait Ansible

Ansible configure les machines :

- role `common` : cree l'utilisateur `deploy` et installe les outils de base ;
- role `web` : installe Nginx et publie la page web ;
- role `db` : installe MariaDB et active le service.

Commande :

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

## Verification attendue

Avec Docker Desktop :

```powershell
docker compose ps
```

Les conteneurs `tp-web` et `tp-db` doivent etre `Up`.

Dans le navigateur :

```text
http://localhost:8080
```

La page doit afficher l'adresse IP de MariaDB.

## Interdictions respectees

- Pas de modification manuelle des machines.
- Pas de script bash pour configurer les serveurs.
- La configuration est declaree dans Terraform, Ansible ou Docker Compose.
