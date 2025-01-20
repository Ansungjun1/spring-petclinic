#!/bin/bash

echo "Remove exited container"
docker compose -f /home/ubuntu/deploy/scripts/docker-compose.yml down || true
