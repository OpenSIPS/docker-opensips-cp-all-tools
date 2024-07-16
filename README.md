# Dockerized OpenSIPS Development Environment

This repository provides a **Docker environment** for developers to work with **OpenSIPS**, **OpenSIPS-CP** (with **all** its **tools**), a **MySQL** server, and both **RTPProxy** and **RTPengine**.

## Installation

Clone the Repository and start the containers:

```bash
git clone https://github.com/OpenSIPS/docker-opensips-cp-all-tools.git
cd dockerized-opensips-env
docker compose up -d
```

## Access

You can access Control Panel at **[http://localhost/cp](http://localhost/cp)**.

## Configuration
You can configure `IP addresses`, `ports`, and other settings in the **`.env`** file, but for the following services you can do more:
- **OpenSIPS** - edit `.cfg` files found in `etc/opensips/`
- **OpenSIPS-CP** - add or remove modules in `etc/opensips-cp/image/modules.inc.php` + you can add your own scripts in `etc/opensips-cp/docker-entrypoint.d/` (they will be executed on container startup)
- **MySQL** - `.sql` scripts at `etc/mysql/` are meant to be executed on container startup, to create the database and tables needed by OpenSIPS
- **RTPProxy** - you can change the range of ports by modifying `MINPORT` and `MAXPORT` in `.env` file

