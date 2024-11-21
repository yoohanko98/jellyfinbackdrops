#!/bin/bash
echo "Starting script..."

# Docker container name
CONTAINER_NAME="jellyfin"

# Path to the file inside the container
FILE_PATH="/usr/share/jellyfin/web/main.jellyfin.bundle.js"

# Backup directory
BACKUP_DIR="$(dirname "$0")/backups"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Generate timestamp for backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Execute the replacement inside the Docker container
docker exec -it "$CONTAINER_NAME" /bin/bash -c "
# Create a backup of the original file
cp '$FILE_PATH' '/tmp/main.jellyfin.bundle.js.backup_$TIMESTAMP'
"

# Copy the backup from the container to the local backup directory
docker cp "$CONTAINER_NAME:/tmp/main.jellyfin.bundle.js.backup_$TIMESTAMP" "$BACKUP_DIR/main.jellyfin.bundle.js.backup_$TIMESTAMP"

# Remove the temporary backup from the container
docker exec -it "$CONTAINER_NAME" /bin/bash -c "
rm '/tmp/main.jellyfin.bundle.js.backup_$TIMESTAMP'
"

# Execute the replacement
docker exec -it "$CONTAINER_NAME" /bin/bash -c "
if grep -q 'enableBackdrops:function(){return R}' '$FILE_PATH'; then
  echo 'Replacing code...'
  sed -i 's/enableBackdrops:function(){return R}/enableBackdrops:function(){return E}/' '$FILE_PATH'
  
  if [ \$? -eq 0 ]; then
    echo 'Replacement completed successfully'
  else
    echo 'Replacement failed'
    exit 1
  fi
else
  echo 'Line already replaced or not found'
  exit 1
fi
"

# Check the exit status of the docker exec command
if [ $? -eq 0 ]; then
  echo "Script completed successfully"
  echo "Backup saved to: $BACKUP_DIR/main.jellyfin.bundle.js.backup_$TIMESTAMP"
else
  echo "Script failed"
  exit 1
fi
