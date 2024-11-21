# Jellyfin Backdrop Modifier Script

## Overview

A simple bash script to modify Jellyfin's backdrop settings, ensuring the change persists through updates when running in a Unraid Docker container.

## Installation in Unraid

### Step-by-Step Guide

1. Open Unraid WebUI
2. Navigate to "Settings" > "User Scripts"
3. Click "Add New Script"
4. Name the script (e.g., "jellyfin_backdrop_enable")
5. Click the new script's settings (gear icon)
6. Select "Edit Script"
7. Paste the entire script contents
8. Save the script
9. Click the settings (gear icon) again
10. Select "Schedule" > "Daily"

## Backup and Restoration

### Backup Location
Backups are stored directly in the Jellyfin web directory:
`/usr/share/jellyfin/web/backups/`

### Restoration Process

1. Enter the Jellyfin Docker container:
   ```bash
   docker exec -it jellyfin /bin/bash
   ```

2. Navigate to the web directory:
   ```bash
   cd /usr/share/jellyfin/web
   ```

3. List available backups:
   ```bash
   ls backups/
   ```

4. Restore a specific backup:
   ```bash
   cp backups/main.jellyfin.bundle.js.backup_YYYYMMDD_HHMMSS main.jellyfin.bundle.js
   ```

   **Replace `YYYYMMDD_HHMMSS` with the actual timestamp of the backup you want to restore**

### Example Full Restoration Walkthrough
```bash
# Enter the container
docker exec -it jellyfin /bin/bash

# Go to the web directory
cd /usr/share/jellyfin/web

# List backups
ls backups/
# Output might look like:
# main.jellyfin.bundle.js.backup_20231215_030405

# Restore a specific backup
cp backups/main.jellyfin.bundle.js.backup_20231215_030405 main.jellyfin.bundle.js

# Exit the container
exit

# Restart Jellyfin container (optional, but recommended)
docker restart jellyfin
```

## What This Script Does

- Creates timestamped backups of `main.jellyfin.bundle.js`
- Modifies the `enableBackdrops` function
- Stores backups in `/usr/share/jellyfin/web/backups/`
- Runs automatically daily to ensure modification persists

### Specific Modification
- Changes `enableBackdrops:function(){return R}` 
- To `enableBackdrops:function(){return E}`

## Customization

Modify these variables in the script:
- `CONTAINER_NAME`: Your Jellyfin Docker container name
- `FILE_PATH`: Verify the path to `main.jellyfin.bundle.js`

## Troubleshooting

### Common Issues
- Verify Docker container name matches exactly
- Ensure Jellyfin container is running
- Check User Scripts logs for detailed output
- Confirm file path is correct for your Jellyfin version

## Caution

⚠️ **Warnings**: 
- Always have a recent backup before modifications
- Modifications might be overwritten by major updates
- Restart Jellyfin after restoration

## Compatibility

Tested with:
- Unraid
- Jellyfin Docker Container
- Bash scripting

## License

Distributed under the MIT License.

## Support

[Open a GitHub issue](https://github.com/yourusername/jellyfin-backdrop-modifier/issues) for any problems.
