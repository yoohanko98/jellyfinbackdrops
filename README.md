# Jellyfin Backdrop Modifier Script

## Overview

A simple bash script to modify Jellyfin's backdrop settings, ensuring the change persists through updates when running in a Unraid Docker container.

## Installation in Unraid

### Step-by-Step Guide

1. Open Unraid WebUI
2. Navigate to "Settings" > "User Scripts"
3. Click "Add New Script"
4. Name the script (e.g., "Jellyfin Backdrop Modifier")
5. Click the new script's settings (gear icon)
6. Select "Edit Script"
7. Paste the entire script contents:
8. Save the script
9. Select "Schedule" > "Daily"

## Customization

Modify these variables in the script:
- `CONTAINER_NAME`: Your Jellyfin Docker container name
- `FILE_PATH`: Verify the path to `main.jellyfin.bundle.js`

## What This Script Does

- Creates a timestamped backup of `main.jellyfin.bundle.js`
- Modifies the `enableBackdrops` function
- Stores backups in a local directory
- Runs automatically daily to ensure modification persists

### Specific Modification
- Changes `enableBackdrops:function(){return R}` 
- To `enableBackdrops:function(){return E}`

## Troubleshooting

### Common Issues
- Verify Docker container name matches exactly
- Ensure Jellyfin container is running
- Check User Scripts logs for detailed output
- Confirm file path is correct for your Jellyfin version

## Backup and Restoration

- Backups stored in: `/boot/config/plugins/user.scripts/scripts/jellyfin_enable_backdrop/backups/`
- To restore, use:
  ```bash
  docker cp backups/main.jellyfin.bundle.js.backup_TIMESTAMP jellyfin:/usr/share/jellyfin/web/main.jellyfin.bundle.js
  ```

## Caution

⚠️ **Warnings**: 
- Backup your Jellyfin configuration first
- Modifications might be overwritten by major updates, so we are running this script daily.

## Compatibility

Tested with:
- Unraid
- Jellyfin Docker Container
- Bash scripting

## License

Distributed under the MIT License.

## Support

[Open a GitHub issue](https://github.com/yourusername/jellyfin-backdrop-modifier/issues) for any problems.
