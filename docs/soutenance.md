# Explication orale niveau 1

## Introduction

J'ai realise le niveau 1 du sujet avec Docker Compose.

Le projet lance une stack minimale avec :

- Nginx ;
- MariaDB ;
- cAdvisor ;
- Prometheus ;
- Grafana.

## Ce que fait chaque service

`web` lance Nginx. Il sert une page web simple accessible sur `localhost:8080`.

`db` lance MariaDB. C'est la base de donnees de la stack.

`cadvisor` collecte les metriques Docker : CPU, memoire, reseau et etat des conteneurs.

`prometheus` recupere les metriques exposees par cAdvisor.

`grafana` affiche ces metriques dans un dashboard.

## Commandes de demo

Je lance la stack :

```powershell
docker compose up -d
```

Je verifie que les conteneurs sont actifs :

```powershell
docker compose ps
```

Je peux ensuite ouvrir :

```text
http://localhost:8080  -> Nginx
http://localhost:8081  -> cAdvisor
http://localhost:9090  -> Prometheus
http://localhost:3001  -> Grafana
```

Pour Grafana :

```text
admin / admin
```

Puis :

```text
Dashboards > TP Niveau 1 > Docker - Vue globale
```

## Ce que je dois montrer au prof

1. `README.md` pour montrer l'objectif et le schema.
2. `docker-compose.yml` pour montrer les services.
3. `monitoring/prometheus/prometheus.yml` pour montrer que Prometheus scrape cAdvisor.
4. `monitoring/grafana/provisioning/datasources/prometheus.yml` pour montrer la datasource.
5. `monitoring/grafana/dashboards/docker-overview.json` pour montrer le dashboard importe.
6. Le terminal avec `docker compose ps`.
7. Le navigateur avec Grafana et le dashboard.

## Phrase de conclusion

Pour conclure, Docker Compose lance les services. cAdvisor expose les metriques des conteneurs. Prometheus collecte ces metriques. Grafana les affiche dans un dashboard. Cela permet de visualiser l'etat de sante de la stack.
