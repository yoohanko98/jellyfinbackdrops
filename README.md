# Jellyfin Backdrop Modifier Script

## Overview

A simple bash script to modify Jellyfin's backdrop settings to enable backdrops for ALL USERS automatically, ensuring the change persists through updates when running in a Unraid Docker container.

Two scripts to modify Jellyfin's backdrop settings:
- One for direct Unraid console execution
- One for Unraid User Scripts plugin

## Script Variations

### 1. Console Execution Script (`jellyfin_enable_backdrops_console.sh`)
- Uses interactive Docker commands
- Runs directly from Unraid console/SSH

### 2. User Scripts Plugin Script (`jellyfin_enable_backdrops_userscript.sh`)
- Non-interactive Docker commands
- Runs through Unraid User Scripts plugin

## Installation Methods

### Method 1: Direct Console Execution

1. Open the Terminal on the Unraid GUI in the top right corner >_
   
3. Create the script file:
   ```bash
   nano jellyfin_enable_backdrops_console.sh
   ```

3. In the nano editor:
   - Right-click to paste (or use Shift+Insert)
   - Paste the entire script contents

4. Save the file:
   - Press `Ctrl+O`
   - Press `Enter` to confirm filename
   - Press `Ctrl+X` to exit nano

5. Make the script executable:
   ```bash
   chmod +x jellyfin_enable_backdrops_console.sh
   ```

### Running the Script

1. Execute the script:
   ```bash
   ./jellyfin_enable_backdrops_console.sh
   ```

### Troubleshooting Console Execution

- **Permission Denied**:
  ```bash
  sudo chmod +x jellyfin_enable_backdrops_console.sh
  ```

- **Docker Connection Issues**:
  - Verify Docker is running
  - Check container name with:
    ```bash
    docker ps
    ```

- **Script Not Working**:
  - Verify container name
  - Check Jellyfin container's file path
  - Confirm Docker permissions   

### Method 2: Unraid User Scripts Plugin

1. Open Unraid WebUI
2. Navigate to "Settings" > "User Scripts"
3. Click "Add New Script"
4. Name the script (e.g., "Jellyfin Backdrop Modifier")
5. Click the gear icon > "Edit Script"
6. Paste contents of `jellyfin_enable_backdrops_userscript.sh`
7. Save the script
8. Configure scheduling (optional)

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

[Open a GitHub issue](https://github.com/yoohanko98/jellyfinbackdrops/issues) for any problems.
