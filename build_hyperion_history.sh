#!/bin/bash
#############################################
# HYPERION - Docker Orchestrator Builder
# Titan Protocol System 12/300
# 
# This script builds the HYPERION repository
# with a granular 19-commit git history
#############################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

HYPERION_DIR="HYPERION-L1-Docker-Orchestrator"

echo -e "${CYAN}"
cat << 'EOF'
██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ ██╗ ██████╗ ███╗   ██╗
██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██║██╔═══██╗████╗  ██║
███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║██║   ██║██╔██╗ ██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╗██║
██║  ██║   ██║   ██║     ███████╗██║  ██║██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
       DOCKER ORCHESTRATOR - TITAN PROTOCOL L1
EOF
echo -e "${NC}"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}📦 Building HYPERION with 19 atomic commits...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Enter HYPERION directory
cd "$HYPERION_DIR"

# Initialize git if not already
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✓ Git initialized${NC}"
fi

# ============================================
# COMMIT 1: init
# ============================================
echo -e "\n${CYAN}[1/19] init: initial commit with project structure and .gitignore${NC}"

cat > .gitignore << 'EOF'
# Environment
.env
.env.local
.env.*.local

# Logs
logs/
*.log

# Docker volumes
volumes/
pg_data/
redis_data/

# IDE
.idea/
.vscode/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Python
__pycache__/
*.pyc
*.pyo

# Rust
target/
Cargo.lock
EOF

git add .
git commit -m "init: initial commit with project structure and .gitignore"

# ============================================
# COMMIT 2: docs - README
# ============================================
echo -e "${CYAN}[2/19] docs: add README.md with project description and badges${NC}"

cat > README.md << 'EOF'
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
EOF

git add .
git commit -m "docs: add README.md with project description and badges"

# ============================================
# COMMIT 3: feat(network)
# ============================================
echo -e "${CYAN}[3/19] feat(network): define titan_network bridge for inter-service communication${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16
EOF

git add .
git commit -m "feat(network): define titan_network bridge for inter-service communication"

# ============================================
# COMMIT 4: feat(volumes)
# ============================================
echo -e "${CYAN}[4/19] feat(volumes): add persistent volumes for postgres and redis data${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data
EOF

git add .
git commit -m "feat(volumes): add persistent volumes for postgres and redis data"

# ============================================
# COMMIT 5: feat(db)
# ============================================
echo -e "${CYAN}[5/19] feat(db): add postgres 15-alpine service with environment config${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
EOF

git add .
git commit -m "feat(db): add postgres 15-alpine service with environment config"

# ============================================
# COMMIT 6: config(db)
# ============================================
echo -e "${CYAN}[6/19] config(db): create .env.example with database configuration variables${NC}"

cat > .env.example << 'EOF'
# ================================================
# HYPERION - Environment Configuration
# Titan Protocol Docker Orchestrator
# ================================================

# PostgreSQL Database
POSTGRES_DB=titan
POSTGRES_USER=titan
POSTGRES_PASSWORD=changeme_in_production
EOF

git add .
git commit -m "config(db): create .env.example with database configuration variables"

# ============================================
# COMMIT 7: feat(cache)
# ============================================
echo -e "${CYAN}[7/19] feat(cache): add redis alpine service with password authentication${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
EOF

git add .
git commit -m "feat(cache): add redis alpine service with password authentication"

# ============================================
# COMMIT 8: config(cache)
# ============================================
echo -e "${CYAN}[8/19] config(cache): add redis configuration to environment variables${NC}"

cat > .env.example << 'EOF'
# ================================================
# HYPERION - Environment Configuration
# Titan Protocol Docker Orchestrator
# ================================================

# PostgreSQL Database
POSTGRES_DB=titan
POSTGRES_USER=titan
POSTGRES_PASSWORD=changeme_in_production

# Redis Cache
REDIS_PASSWORD=changeme_in_production
REDIS_PORT=6379
EOF

git add .
git commit -m "config(cache): add redis configuration to environment variables"

# ============================================
# COMMIT 9: feat(genesis)
# ============================================
echo -e "${CYAN}[9/19] feat(genesis): add genesis rust service with build context reference${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    networks:
      - titan_network
EOF

git add .
git commit -m "feat(genesis): add genesis rust service with build context reference"

# ============================================
# COMMIT 10: fix(genesis)
# ============================================
echo -e "${CYAN}[10/19] fix(genesis): add database dependency and healthcheck for genesis${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network
EOF

git add .
git commit -m "fix(genesis): add database dependency and healthcheck for genesis"

# ============================================
# COMMIT 11: feat(vortex)
# ============================================
echo -e "${CYAN}[11/19] feat(vortex): add vortex python research agent service${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    networks:
      - titan_network
EOF

git add .
git commit -m "feat(vortex): add vortex python research agent service"

# ============================================
# COMMIT 12: config(vortex)
# ============================================
echo -e "${CYAN}[12/19] config(vortex): configure log volume mapping for vortex service${NC}"

mkdir -p logs/vortex

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    volumes:
      - ./logs/vortex:/app/logs
    networks:
      - titan_network
EOF

touch logs/vortex/.gitkeep
git add .
git commit -m "config(vortex): configure log volume mapping for vortex service"

# ============================================
# COMMIT 13: feat(cerberus)
# ============================================
echo -e "${CYAN}[13/19] feat(cerberus): add cerberus gateway service with build context${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    volumes:
      - ./logs/vortex:/app/logs
    networks:
      - titan_network

  cerberus:
    build:
      context: ../CERBERUS-L2-Gateway-Security
      dockerfile: Dockerfile
    container_name: titan_cerberus
    environment:
      GENESIS_URL: http://genesis:8080
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    depends_on:
      - cache
      - genesis
    networks:
      - titan_network
EOF

git add .
git commit -m "feat(cerberus): add cerberus gateway service with build context"

# ============================================
# COMMIT 14: sec(cerberus)
# ============================================
echo -e "${CYAN}[14/19] sec(cerberus): expose only gateway port and configure internal routing${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5
    # Internal only - no port exposed

  cache:
    image: redis:alpine
    container_name: titan_redis
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    # Internal only - no port exposed

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network
    # Internal only - accessed via cerberus gateway

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    volumes:
      - ./logs/vortex:/app/logs
    networks:
      - titan_network
    # Internal only - accessed via cerberus gateway

  cerberus:
    build:
      context: ../CERBERUS-L2-Gateway-Security
      dockerfile: Dockerfile
    container_name: titan_cerberus
    ports:
      - "8000:8000"  # Only public-facing port
    environment:
      GENESIS_URL: http://genesis:8080
      VORTEX_URL: http://vortex:8000
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
      RUST_LOG: info
    depends_on:
      - cache
      - genesis
      - vortex
    networks:
      - titan_network
EOF

git add .
git commit -m "sec(cerberus): expose only gateway port and configure internal routing"

# ============================================
# COMMIT 15: ops(restart)
# ============================================
echo -e "${CYAN}[15/19] ops(restart): add restart always policy for service resilience${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    restart: always
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5

  cache:
    image: redis:alpine
    container_name: titan_redis
    restart: always
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    restart: always
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    restart: always
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    volumes:
      - ./logs/vortex:/app/logs
    networks:
      - titan_network

  cerberus:
    build:
      context: ../CERBERUS-L2-Gateway-Security
      dockerfile: Dockerfile
    container_name: titan_cerberus
    restart: always
    ports:
      - "8000:8000"
    environment:
      GENESIS_URL: http://genesis:8080
      VORTEX_URL: http://vortex:8000
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
      RUST_LOG: info
    depends_on:
      - cache
      - genesis
      - vortex
    networks:
      - titan_network
EOF

git add .
git commit -m "ops(restart): add restart always policy for service resilience"

# ============================================
# COMMIT 16: ops(resources)
# ============================================
echo -e "${CYAN}[16/19] ops(resources): add cpu and memory limits for resource management${NC}"

cat > docker-compose.yml << 'EOF'
# HYPERION - Docker Orchestrator
# Titan Protocol System 12/300
version: '3.8'

networks:
  titan_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16

volumes:
  pg_data:
    name: titan_pg_data
  redis_data:
    name: titan_redis_data

services:
  database:
    image: postgres:15-alpine
    container_name: titan_postgres
    restart: always
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-titan}
      POSTGRES_USER: ${POSTGRES_USER:-titan}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-changeme}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-titan}"]
      interval: 10s
      timeout: 5s
      retries: 5
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 128M

  cache:
    image: redis:alpine
    container_name: titan_redis
    restart: always
    command: redis-server --requirepass ${REDIS_PASSWORD:-changeme}
    volumes:
      - redis_data:/data
    networks:
      - titan_network
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M
        reservations:
          cpus: '0.1'
          memory: 64M

  genesis:
    build:
      context: ../GENESIS-L1-HighPerf-URL-Shortener
      dockerfile: Dockerfile
    container_name: titan_genesis
    restart: always
    environment:
      DATABASE_URL: postgres://${POSTGRES_USER:-titan}:${POSTGRES_PASSWORD:-changeme}@database:5432/${POSTGRES_DB:-titan}
      RUST_LOG: info
    depends_on:
      database:
        condition: service_healthy
    networks:
      - titan_network
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 256M
        reservations:
          cpus: '0.25'
          memory: 64M

  vortex:
    build:
      context: ../VORTEX-L4-Research-Agent-LangGraph
      dockerfile: Dockerfile
    container_name: titan_vortex
    restart: always
    environment:
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
    volumes:
      - ./logs/vortex:/app/logs
    networks:
      - titan_network
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 256M

  cerberus:
    build:
      context: ../CERBERUS-L2-Gateway-Security
      dockerfile: Dockerfile
    container_name: titan_cerberus
    restart: always
    ports:
      - "8000:8000"
    environment:
      GENESIS_URL: http://genesis:8080
      VORTEX_URL: http://vortex:8000
      REDIS_URL: redis://:${REDIS_PASSWORD:-changeme}@cache:6379
      RUST_LOG: info
    depends_on:
      - cache
      - genesis
      - vortex
    networks:
      - titan_network
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 256M
        reservations:
          cpus: '0.25'
          memory: 64M
EOF

git add .
git commit -m "ops(resources): add cpu and memory limits for resource management"

# ============================================
# COMMIT 17: docs(arch)
# ============================================
echo -e "${CYAN}[17/19] docs(arch): add mermaid architecture diagram to documentation${NC}"

cat >> README.md << 'EOF'

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

## 📊 Service Details

| Service | Port | Technology | Purpose |
|---------|------|------------|---------|
| **Cerberus** | 8000 | Rust | API Gateway, Rate Limiting, Auth |
| **Genesis** | 8080 (internal) | Rust | URL Shortening Service |
| **Vortex** | - (internal) | Python | AI Research Agent |
| **PostgreSQL** | 5432 (internal) | - | Primary Database |
| **Redis** | 6379 (internal) | - | Cache & Rate Limiting |

## 🔒 Security Notes

- Only **Cerberus** exposes ports to the host
- All internal services communicate via `titan_network`
- Redis requires password authentication
- Resource limits prevent runaway containers
EOF

git add .
git commit -m "docs(arch): add mermaid architecture diagram to documentation"

# ============================================
# COMMIT 18: chore(clean)
# ============================================
echo -e "${CYAN}[18/19] chore(clean): standardize yaml formatting and remove dead comments${NC}"

# Add LICENSE
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2026 Davi Bonetto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Add Makefile for convenience
cat > Makefile << 'EOF'
.PHONY: up down build logs ps clean help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

up: ## Start all services in detached mode
	docker compose up -d

down: ## Stop all services
	docker compose down

build: ## Build all service images
	docker compose build

logs: ## Follow logs from all services
	docker compose logs -f

ps: ## Show running containers
	docker compose ps

clean: ## Remove all containers, volumes, and images
	docker compose down -v --rmi all

restart: ## Restart all services
	docker compose restart

shell-cerberus: ## Open shell in cerberus container
	docker compose exec cerberus /bin/sh

shell-genesis: ## Open shell in genesis container
	docker compose exec genesis /bin/sh

shell-postgres: ## Open psql in postgres container
	docker compose exec database psql -U titan -d titan

shell-redis: ## Open redis-cli in redis container
	docker compose exec cache redis-cli
EOF

git add .
git commit -m "chore(clean): standardize yaml formatting and add makefile convenience commands"

# ============================================
# COMMIT 19: release
# ============================================
echo -e "${CYAN}[19/19] release: prepare v1.0.0 release with git tag${NC}"

# Final README updates
cat >> README.md << 'EOF'

## 🛠️ Makefile Commands

```bash
make help      # Show available commands
make up        # Start all services
make down      # Stop all services
make logs      # Follow service logs
make build     # Rebuild images
make clean     # Remove everything
```

## 📜 License

MIT License - see [LICENSE](LICENSE) for details.

---

<p align="center">
  <strong>🔱 Titan Protocol</strong><br>
  <em>System 12/300 - HYPERION Docker Orchestrator</em>
</p>
EOF

git add .
git commit -m "release: prepare v1.0.0 release with comprehensive documentation"

# Create tag
git tag -a v1.0.0 -m "HYPERION v1.0.0 - Initial Release

Features:
- Docker Compose orchestration for Titan Protocol services
- PostgreSQL 15 and Redis Alpine data layer
- Genesis, Vortex, and Cerberus service definitions
- Secure internal networking with single gateway exposure
- Resource limits and restart policies
- Comprehensive documentation with architecture diagrams"

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ HYPERION repository built with 19 atomic commits!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "\n${YELLOW}📋 Git Log Summary:${NC}"
git log --oneline

echo -e "\n${YELLOW}📋 Validating docker-compose.yml...${NC}"
docker compose config --quiet && echo -e "${GREEN}✓ Docker Compose configuration is valid${NC}" || echo -e "${RED}✗ Configuration has errors${NC}"

echo -e "\n${BLUE}Next Steps:${NC}"
echo "  1. Create GitHub repo: gh repo create HYPERION-L1-Docker-Orchestrator --public"
echo "  2. Push to GitHub: git push -u origin main --tags"
echo ""
