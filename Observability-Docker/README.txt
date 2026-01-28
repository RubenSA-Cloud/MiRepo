# Observability Docker - Sistema de Monitoreo

Un stack completo de observabilidad con **Prometheus** (métricas), **Loki** (logs) y **Grafana** (visualización).

## 📋 Componentes

- **Prometheus**: Recolecta métricas cada 15 segundos
- **Loki**: Agrega logs de contenedores Docker
- **Promtail**: Agente que envía logs a Loki (auto-descubre contenedores)
- **Grafana**: Dashboard unificado para métricas y logs

## 🚀 Inicio rápido

```bash
docker-compose up -d


Servicio	URL	Credenciales
Grafana	http://localhost:3000	admin / admin
Prometheus	http://localhost:9090	—
Loki	http://localhost:3100	—