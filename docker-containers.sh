#!/bin/bash

# Fetch and display container details using Docker's default formatting
docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
