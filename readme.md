# Docker and Kubernetes

Welcome to the Docker and Kubernetes Practice Repository!

## Introduction

**Docker**: Docker is a powerful tool for containerization that simplifies the deployment and management of applications.

- **Containerization Platform**: Docker allows you to package an application along with its dependencies into a standardized unit called a container. This container can then be run on any system that has Docker installed, regardless of the underlying OS.
- **Consistency**: Docker ensures that the software will always run the same, regardless of where it's deployed, reducing the "it works on my machine" problem.
- **Efficiency**: Containers share the host system's kernel, making them more lightweight than virtual machines (VMs), which require full OS installations.

**Important:** Dockerized a full stack (React, Spring Boot, and MySQL) project. **See the Dockerized project: [ExpenseWise](https://github.com/ksachin7/ExpenseWise)**

See the [Terminal saved output](./docker_deploy.txt) of dockerizing the project and issue faced.

**Here's a table of Docker commands used**

| **Command**                                            | **Description**                                                                                     |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| `docker --version`                                   | Displays the installed Docker version.                                                             |
| `docker pull <image_name>`                           | Downloads the specified image from Docker Hub or another registry.                                 |
| `docker images`                                      | Lists all Docker images on your local machine.                                                     |
| `docker ps`                                           | Lists all running containers.                                                                      |
| `docker container ls`                                | Alternative command to `docker ps` for listing running containers.                                 |
| `docker run -d <image_name>`                         | Runs a new container from the specified image in detached mode (`-d`).                             |
| `docker info`                                        | Provides detailed information about Docker's configuration and status.                             |
| `docker stop <container_name_or_id>`                  | Stops the specified container.                                                                     |
| `docker rm <container_name_or_id>`                    | Removes the specified container.                                                                   |
| `docker ps -a`                                       | Lists all containers (running and stopped).                                                        |
| `docker ps -aq`                                      | Lists all container IDs (quiet mode).                                                               |
| `docker run --name <container_name> -p <host_port>:<container_port> <image_name>` | Runs a new container with specific port mappings and a name.                                       |
| `docker exec -it <container_id> /bin/sh`              | Opens an interactive shell inside the specified container.                                          |
| `docker volume ls`                                   | Lists all Docker volumes.                                                                          |
| `docker volume inspect <volume_id>`                   | Provides detailed information about a specific volume.                                             |
| `docker volume create <volume_name>`                  | Creates a new named volume.                                                                        |
| `docker volume rm <volume_id>`                        | Removes the specified volume.                                                                     |
| `docker rmi <image_id>`                               | Removes a specific image from the local storage.                                                    |
| `docker build --tag <tag_name> .`                     | Builds a Docker image from the Dockerfile in the current directory and tags it.                     |
| `docker logs <container_name_or_id>`                  | Shows logs from the specified container.                                                            |
| `docker history <image_name>`                         | Displays the history of an image, showing how it was built.                                         |
| `docker run --name <container_name> -v <host_path>:<container_path> <image_name>` | Runs a new container with a volume mount.                                                            |
| `docker run --name <container_name> -v <host_path>:<container_path>:ro <image_name>` | Runs a new container with a read-only volume mount.                                                 |
| `docker volume create <volume_name>`                  | Creates a named volume for sharing data between containers.                                        |
| `docker inspect <container_id>`                       | Provides detailed information about a specific container.                                           |
| `docker volume prune`                                | Removes all unused volumes.                                                                        |
| `docker system prune`                                | Cleans up all unused Docker data, including stopped containers, unused images, and networks.         |

**Table of customized commands**
These are custom commands defined in a script and are not actual Docker commands.

| **Custom Command**                            | **Description**                                                                                   |
|--------------------------------------|---------------------------------------------------------------------------------------------------|
| `docker-volumes`                     | Lists all containers and their volumes.                                       |
| `docker-vol-usage`                   | Lists all containers using a specific volume.                                 |
| `docker-prune-volumes`               | Stops all running containers, removes all containers, prunes unused volumes, and attempts to remove specific volumes. |
| `docker-logs`                        | Shows the logs of a specified container.                                       |
| `docker-details`                     | Lists all containers with detailed information (ID, Names, Image, Ports, Status). |
| `docker-detailed-vol-usage`          | Lists all containers using a specific volume with detailed information (ID, Name, Image, Mounts, Ports, Status). |

**Kubernetes**: Kubernetes, often abbreviated as K8s, is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.
