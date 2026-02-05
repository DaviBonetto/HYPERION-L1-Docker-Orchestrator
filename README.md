# 🌐 HYPERION - Docker Orchestrator

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)](https://redis.io/)

> **Titan Protocol System 12/300**  
> Unified Docker orchestration for the Titan Protocol microservices ecosystem.

## 📋 Overview

HYPERION is the central Docker Compose orchestrator that coordinates all Titan Protocol services:

- **GENESIS** - High-Performance URL Shortener (Rust, L1)
- **VORTEX** - Research Agent with LangGraph (Python, L4)
- **CERBERUS** - Gateway Security Service (Rust, L2)

## 🚀 Quick Start

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

## 📁 Project Structure

```
HYPERION-L1-Docker-Orchestrator/
├── docker-compose.yml     # Main orchestration file
├── .env.example           # Environment template
├── .gitignore
└── README.md
```
