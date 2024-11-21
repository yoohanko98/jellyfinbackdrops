#!/bin/bash
echo "Starting script..."

# Docker container name
CONTAINER_NAME="jellyfin"

# Path to the file inside the container
FILE_PATH="/usr/share/jellyfin/web/main.jellyfin.bundle.js"

# Backup directory (same as file location)
BACKUP_DIR="/usr/share/jellyfin/web/backups"

# Execute the replacement inside the Docker container
docker exec "$CONTAINER_NAME" /bin/bash -c '
# Create backup directory if it does not exist
mkdir -p "'$BACKUP_DIR'"

# Check if replacement is needed
if grep -q "enableBackdrops:function(){return R}" "'$FILE_PATH'"; then
  echo "Modification needed. Proceeding with changes."
  
  # Generate timestamp for backup filename
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  
  # Create backup of the original file
  cp "'$FILE_PATH'" "'$BACKUP_DIR'/main.jellyfin.bundle.js.backup_$TIMESTAMP"
  
  # Perform the replacement
  sed -i "s/enableBackdrops:function(){return R}/enableBackdrops:function(){return E}/" "'$FILE_PATH'"
  
  if [ $? -eq 0 ]; then
    echo "Replacement completed successfully"
    echo "Backup saved to: '$BACKUP_DIR'/main.jellyfin.bundle.js.backup_$TIMESTAMP"
  else
    echo "Replacement failed"
    exit 1
  fi
else
  echo "No modification required. Existing configuration is correct."
  exit 0
fi
'

# Check the exit status of the docker exec command
if [ $? -eq 0 ]; then
  echo "Script completed successfully"
else
  echo "Script failed"
  exit 1
fi
