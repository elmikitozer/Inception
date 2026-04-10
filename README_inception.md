# Inception

A Docker-based infrastructure project built as part of the École 42 curriculum.  
Sets up a complete multi-service web stack inside a virtual machine — entirely from custom-built images.

---

## What it does

`Inception` orchestrates a production-style LEMP stack using Docker Compose:

- **NGINX** — reverse proxy with TLS (SSL/TLS 1.2/1.3 only), single entry point
- **WordPress** — PHP-FPM, configured via `wp-cli`, no pre-built image
- **MariaDB** — relational database, isolated on its own network
- **Volumes** — persistent storage for the database and WordPress files
- **Networks** — services communicate on an internal Docker network, only NGINX is exposed

All images are built from custom `Dockerfile`s based on `debian:bullseye` or `alpine` — no pulling from Docker Hub.

---

## Why this project matters

Most developers use Docker without ever thinking about what's inside the images they pull. Inception forces you to:

- **Write Dockerfiles from scratch** — understand what goes in a base image, why `CMD` vs `ENTRYPOINT` matters, what PID 1 actually means
- **Manage inter-service communication** — containers talk to each other by service name, not IP
- **Handle secrets properly** — credentials in `.env`, never hardcoded in config files
- **Think about startup order** — WordPress can't start before MariaDB is ready
- **Configure TLS manually** — generate certs, configure NGINX to enforce them

The constraint of "no pre-built images" is what makes the project educational. You can't skip the plumbing.

---

## Architecture

```
Inception/
├── Makefile
└── srcs/
    ├── .env                        # Credentials and config (not committed)
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/nginx.conf
        ├── wordpress/
        │   ├── Dockerfile
        │   └── tools/wordpress_start.sh
        └── mariadb/
            ├── Dockerfile
            └── tools/mariadb_start.sh
```

---

## Build & run

```bash
# Fill in your credentials
cp srcs/.env.example srcs/.env

# Build and start all services
make

# Tear everything down (keeps volumes)
make down

# Full reset including volumes
make fclean
```

The site is accessible at `https://elmikitozer.42.fr` (add to `/etc/hosts` locally).

---

## Constraints

- No `--link`, no `network: host`, no exposed ports except on NGINX
- No `tail -f` or `sleep infinity` as PID 1 — processes run in the foreground
- Images built from `debian:bullseye` or `alpine` only — no DockerHub pulls
- `latest` tag forbidden
- Credentials never hardcoded — all via `.env`
- Restarts automatically on failure (`restart: unless-stopped`)

---

## Reference

- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX SSL configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [WordPress CLI](https://wp-cli.org/)
