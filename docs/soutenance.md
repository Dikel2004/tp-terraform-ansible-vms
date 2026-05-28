# Explication orale niveau 1

## Phrase de depart

J'ai realise le niveau 1 du TP.

Le but est de creer une petite infrastructure avec deux machines :

- une machine web avec Nginx ;
- une machine base de donnees avec MariaDB.

Les deux machines sont dans le meme reseau.

## Explication simple

Terraform sert a creer les machines et le reseau.

Ensuite Ansible sert a configurer les machines :

- il cree l'utilisateur `deploy` ;
- il installe Nginx sur la machine web ;
- il installe MariaDB sur la machine db ;
- il demarre les services.

Je ne modifie pas les machines a la main. Tout est ecrit dans les fichiers du projet.

## Demo avec Docker Desktop

Comme je travaille sur Windows, je montre la demo avec Docker Desktop.

Docker lance deux conteneurs :

- `tp-web` pour Nginx ;
- `tp-db` pour MariaDB.

Les deux conteneurs sont dans le meme reseau Docker.

Je lance avec :

```powershell
docker compose up -d
```

Je verifie avec :

```powershell
docker compose ps
```

Puis j'ouvre :

```text
http://localhost:8080
```

La page affiche l'adresse IP de MariaDB. Cela prouve que le service web connait le service base de donnees.

## Ce que je peux dire si le prof demande pourquoi Docker

La consigne parle de VMs avec Terraform et Ansible. Cette partie est presente dans les dossiers `terraform` et `ansible`.

Sur mon PC Windows, j'utilise Docker Desktop pour faire une demonstration locale plus simple a lancer.

La logique reste la meme :

- un serveur web ;
- un serveur base de donnees ;
- un reseau commun ;
- une page web accessible.
