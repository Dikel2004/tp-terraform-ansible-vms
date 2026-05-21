# Support oral rapide

## Idee generale

Le projet separe clairement deux roles :

- Terraform construit l'infrastructure.
- Ansible configure les serveurs.

Terraform ne configure pas Nginx ou MariaDB. Il cree seulement les VMs, le reseau et les fichiers utiles pour Ansible.

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
