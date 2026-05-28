# Checklist niveau 1

## Stack minimale

- Docker Compose : `docker-compose.yml`
- Conteneur Nginx : service `web`
- Conteneur MariaDB : service `db`

## Monitoring et observabilite

- cAdvisor : service `cadvisor`
- Prometheus : service `prometheus`
- Configuration Prometheus : `monitoring/prometheus/prometheus.yml`
- Grafana : service `grafana`
- Datasource Grafana : `monitoring/grafana/provisioning/datasources/prometheus.yml`
- Dashboard Grafana : `monitoring/grafana/dashboards/docker-overview.json`

## Rendu

- Repo GitHub sur une branche `main`
- README expliquant chaque service
- Schema global des services
- Screenshot dashboard Grafana a faire pendant la demo
- Soutenance orale : `docs/soutenance.md`
