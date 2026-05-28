# TP Niveau 1 - Docker Compose, Monitoring et Grafana

Ce projet correspond au niveau 1 du sujet.

Objectif :

- lancer 2 conteneurs avec Docker Compose :
  - Nginx ;
  - MariaDB ;
- collecter des metriques systeme avec Prometheus et cAdvisor ;
- visualiser l'etat de sante dans Grafana ;
- fournir un README clair et un schema simple des services.

## Services

| Service | Role | URL |
| --- | --- | --- |
| `web` | Serveur Nginx | http://localhost:8080 |
| `db` | Base MariaDB | port interne 3306 |
| `cadvisor` | Metriques Docker | http://localhost:8081 |
| `prometheus` | Collecte les metriques | http://localhost:9090 |
| `grafana` | Dashboard de visualisation | http://localhost:3000 |

Identifiants Grafana :

```text
admin / admin
```

## Schema global

```text
Navigateur
   |
   v
Nginx web --------------+
                        |
MariaDB db              |
                        |
cAdvisor collecte les metriques Docker
   |
   v
Prometheus stocke les metriques
   |
   v
Grafana affiche le dashboard
```

## Lancer le projet

Depuis le dossier du projet :

```powershell
docker compose up -d
```

Verifier les conteneurs :

```powershell
docker compose ps
```

Arreter :

```powershell
docker compose down
```

Supprimer aussi les donnees :

```powershell
docker compose down -v
```

## Verification

1. Ouvrir Nginx :

```text
http://localhost:8080
```

2. Ouvrir cAdvisor :

```text
http://localhost:8081
```

3. Ouvrir Prometheus :

```text
http://localhost:9090
```

Dans Prometheus, aller dans `Status > Targets` et verifier que `cadvisor` est `UP`.

4. Ouvrir Grafana :

```text
http://localhost:3000
```

Connexion :

```text
admin / admin
```

Dashboard :

```text
Dashboards > TP Niveau 1 > Docker - Vue globale
```

## Fichiers importants

```text
docker-compose.yml
monitoring/prometheus/prometheus.yml
monitoring/grafana/provisioning/datasources/prometheus.yml
monitoring/grafana/provisioning/dashboards/default.yml
monitoring/grafana/dashboards/docker-overview.json
docker/web/index.html.template
docs/soutenance.md
```

## Ce que fait chaque service

`web` lance Nginx et affiche une page HTML simple.

`db` lance MariaDB avec une base `tp_database`.

`cadvisor` lit les informations Docker et expose les metriques des conteneurs.

`prometheus` interroge cAdvisor regulierement et stocke les metriques.

`grafana` utilise Prometheus comme source de donnees et affiche un dashboard.

## Screenshot Grafana

Pour le rendu, ouvrir Grafana, afficher le dashboard, puis faire une capture d'ecran.

Le dashboard attendu est :

```text
Docker - Vue globale
```
