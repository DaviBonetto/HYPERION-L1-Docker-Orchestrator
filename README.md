<div align="center">

```
  ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ ██╗ ██████╗ ███╗   ██╗
  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██║██╔═══██╗████╗  ██║
  ███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║██║   ██║██╔██╗ ██║
  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╗██║
  ██║  ██║   ██║   ██║     ███████╗██║  ██║██║╚██████╔╝██║ ╚████║
  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
```

### 🐳 System 12/300: Docker Compose Orchestrator

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)](https://redis.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

**Unified Orchestration for the Titan Protocol Microservices**

---

[Quick Start](#-quick-start) • [Architecture](#-architecture) • [Services](#-service-details)

</div>

---

## 🚀 Quick Star

```bash
# Clone the repository
git clone https://github.com/DaviBonetto/HYPERION-L1-Docker-Orchestrator.git
cd HYPERION-L1-Docker-Orchestrator

# Configure environment
cp .env.example .env

# Start all services
docker compose up -d

# View logs
docker compose logs -f
```

---

## 🏗️ Architecture

```mermaid
flowchart TB
    subgraph External
        Client[🌐 Client]
    end

    subgraph HYPERION["🐳 Docker Compose Orchestrator"]
        subgraph Gateway
            Cerberus[🔒 CERBERUS<br/>Gateway Security<br/>:8000]
        end

        subgraph Services
            Genesis[⚡ GENESIS<br/>URL Shortener<br/>:8080]
            Vortex[🌀 VORTEX<br/>Research Agent]
        end

        subgraph Data
            Postgres[(🐘 PostgreSQL<br/>:5432)]
            Redis[(⚡ Redis<br/>:6379)]
        end
    end

    Client --> Cerberus
    Cerberus --> Genesis
    Cerberus --> Vortex
    Genesis --> Postgres
    Vortex --> Redis
    Cerberus --> Redis

    style Cerberus fill:#e74c3c
    style Genesis fill:#3498db
    style Vortex fill:#9b59b6
    style Postgres fill:#2ecc71
    style Redis fill:#e67e22
```

---

## 📊 Service Details

| Service        | Port            | Technology | Purpose                          |
| -------------- | --------------- | ---------- | -------------------------------- |
| **Cerberus**   | 8000            | Rust       | API Gateway, Rate Limiting, Auth |
| **Genesis**    | 8080 (internal) | Rust       | URL Shortening Service           |
| **Vortex**     | - (internal)    | Python     | AI Research Agent                |
| **PostgreSQL** | 5432 (internal) | -          | Primary Database                 |
| **Redis**      | 6379 (internal) | -          | Cache & Rate Limiting            |

---

## 📁 Project Structure

```
HYPERION-L1-Docker-Orchestrator/
├── docker-compose.yml     # Main orchestration file
├── .env.example           # Environment template
├── Makefile               # Convenience commands
├── LICENSE                # MIT License
└── README.md
```

---

## 🔒 Security Notes

- Only **Cerberus** exposes ports to the host
- All internal services communicate via `titan_network`
- Redis requires password authentication
- Resource limits prevent runaway containers

---

## 🛠️ Makefile Commands

```bash
make help      # Show available commands
make up        # Start all services
make down      # Stop all services
make logs      # Follow service logs
make build     # Rebuild images
make clean     # Remove everything
```

---

## 🔗 Titan Protocol Initiative

| System     | Name         | Technology  |
| ---------- | ------------ | ----------- |
| 08/300     | HERMES       | Go + gRPC   |
| 09/300     | CERBERUS     | Rust + Axum |
| **12/300** | **HYPERION** | **Docker**  |

---

<div align="center">

**Built with 🐳 Docker + ⚡ Compose by [Davi Bonetto](https://github.com/DaviBonetto)**

_Part of the Titan Protocol Initiative_

</div>
