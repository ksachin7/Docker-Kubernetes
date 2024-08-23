#!/bin/bash

set -e  # Exit immediately on error

# List all containers and their volumes
function list_container_volumes() {
  # echo "Listing all containers and their volumes..."
  local containers=$(docker ps -a -q)

  if [ -z "$containers" ]; then
    echo "No containers found."
    return 1
  fi

  for container in $containers; do
    echo "Container ID: $container"
    local mounts=$(docker inspect --format '{{range .Mounts}}{{println .Source}}{{end}}' $container)
    if [ -z "$mounts" ]; then
      echo "  No volumes mounted."
    else
      echo "  Mounted volumes:"
      echo "  +"
      echo "  └── $mounts"    
    fi
    echo ""
  done
}

# List all containers using a specific volume
function containers_using_volume() {
  if [ -z "$1" ]; then
    echo "Usage: docker-vol-usage <volume_name>"
    return 1
  fi

  local volume=$1
  echo "Containers using volume: $volume"
  local containers=$(docker ps -a -q)

  if [ -z "$containers" ]; then
    echo "No containers found."
    return 1
  fi

  for container in $containers; do
    local mounts=$(docker inspect --format '{{range .Mounts}}{{println .Name}}{{end}}' $container)
    if echo "$mounts" | grep -q "$volume"; then
      echo "  Container ID: $container"
    fi
  done
}

# Remove all unused volumes
function prune_all_volumes() {
  # echo "Stopping Containers & Removing all Docker volumes..."

  # List of all running container IDs
  running_containers=$(docker ps -q)

  # Check if there are any running containers
  if [ -n "$running_containers" ]; then
    # Stop all running containers and capture the output (container IDs)
    stopped_containers=$(docker stop $running_containers)
    echo "Stopped: $stopped_containers"
  else
    echo "No running containers to stop."
  fi

  echo ""
  # List volumes before pruning
  echo "Volumes before pruning"
  echo "---------------------"
  docker volume ls

  echo ""
  # Prune all unused volumes
  docker volume prune -f

  echo ""
  # List volumes after pruning
  echo "Volumes after pruning"
  echo "---------------------"
  docker volume ls
}


# Show the logs of a container
function show_logs() {
  if [ -z "$1" ]; then
    echo "Usage: docker-logs <container_name_or_id>"
    return 1
  fi

  local container=$1
  echo "Showing logs for container: $container"
  docker logs $container
}

# Fetch and display container details using Docker's default formatting
function list_container_details() {
  # echo "Listing all containers with details..."
  docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
}

# List all containers with useful info that are using a specific volume
function detailed_containers_using_volume() {
  if [ -z "$1" ]; then
    echo "Usage: docker-detailed-vol-usage <volume_name>"
    return 1
  fi

  local volume=$1
  echo "* Containers using volume: $volume"
  local containers=$(docker ps -a -q)

  if [ -z "$containers" ]; then
    echo "No containers found."
    return 1
  fi

  for container in $containers; do
    local mounts=$(docker inspect --format '{{range .Mounts}}{{println .Name}}{{end}}' $container)
    if echo "$mounts" | grep -q "$volume"; then
      echo "+ Container ID: $container"
      docker inspect --format='+ Container ID: {{.Id}}
+ Name: {{.Name}}
+ Image: {{.Config.Image}}
+ Mounts:
{{range .Mounts}}  - Source: {{.Source}}
  - Destination: {{.Destination}}
{{end}}+ Ports:
{{range $port, $bindings := .NetworkSettings.Ports}}{{range $bindings}}  - {{$port}}:{{.HostPort}}
{{end}}{{end}}
+ Status: {{.State.Status}}
' $container
      # echo "---------------------------------------"
    fi
  done
}

# Function calls for testing
case "$1" in
  list_container_volumes)
    list_container_volumes
    ;;
  list_container_details)
    list_container_details
    ;;
  show_logs)
    show_logs "$2"
    ;;
  containers_using_volume)
    containers_using_volume "$2"
    ;;
  detailed_containers_using_volume)
    detailed_containers_using_volume "$2"
    ;;
  prune_all_volumes)
    prune_all_volumes
    ;;
  *)
    echo "Usage: $0 {list_container_volumes|list_container_details|show_logs <container_name_or_id>|containers_using_volume <volume_name>|detailed_containers_using_volume <volume_name>|prune_all_volumes}"
    ;;
esac

# Define aliases (requires .zshrc to be sourced to work in a new terminal)
# if [ "$SHELL" == "/bin/zsh" ]; then
#   # echo "Setting up Zsh aliases..."
#   echo "alias docker-volumes='bash $DOCKER_SCRIPTS_PATH list_container_volumes'" >> ~/.zshrc
#   echo "alias docker-vol-usage='bash $DOCKER_SCRIPTS_PATH containers_using_volume'" >> ~/.zshrc
#   echo "alias docker-prune-volumes='bash $DOCKER_SCRIPTS_PATH prune_all_volumes'" >> ~/.zshrc
#   echo "alias docker-logs='bash $DOCKER_SCRIPTS_PATH show_logs'" >> ~/.zshrc
#   echo "alias docker-details='bash $DOCKER_SCRIPTS_PATH list_container_details'" >> ~/.zshrc
#   echo "alias docker-detailed-vol-usage='bash $DOCKER_SCRIPTS_PATH detailed_containers_using_volume'" >> ~/.zshrc
# fi
