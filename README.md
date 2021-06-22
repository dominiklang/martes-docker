# martes-docker

This project provides the whole environment as docker-containers for the martes project. Martes is a tool to test the security configuration of MQTT Servers. The user can configure tests which should be run against the desired MQTT Server. This way, the configuration of for example access control and authorization can be tested.

## Prerequisites

* Git: https://git-scm.com/downloads
* Docker Compose: https://docs.docker.com/compose/install/

## Installation

1. Clone the git repo: `git@github.com:dominiklang/martes-docker.git`
2. Switch into the directory: `cd martes-docker`
3. Build and run martes with Compose: `docker-compose up`
4. Open martes in your browser: `http://localhost:8080`