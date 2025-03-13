#!/bin/bash

# Define the container name
CONTAINER_NAME="hea"

# Ensure the destination directory exists in the container
docker exec $CONTAINER_NAME mkdir -p /data

# Loop through all .dat files in the current directory
for file in *.dat; do
    # Check if any .dat files exist (avoids errors if none are found)
    if [ -f "$file" ]; then
        echo "Copying $file to $CONTAINER_NAME:/data/"
        docker cp "$file" "$CONTAINER_NAME:/data/"
    else
        echo "No .dat files found in the current directory."
        exit 1
    fi
done

echo "All .dat files have been copied to $CONTAINER_NAME:/data/"