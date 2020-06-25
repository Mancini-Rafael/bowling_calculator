#!/bin/bash -e

echo "=== Starting project setup for docker development environment ==="
if ! command -v 'docker-compose' > /dev/null; then
  echo "Docker Compose not installed. Install before continuing."
  exit 1
fi

echo "=== Docker Compose installed. Proceeding... ==="
echo "=== Building containers ==="
docker-compose build calculator
echo "=== Will bundle dependencies for first time (subsequent call will be much faster)==="
docker-compose run calculator
echo "Setup Finished! Run \"docker-compose up\" to get started"