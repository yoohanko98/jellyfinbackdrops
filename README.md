# Jellyfin Backdrop Modifier Script

## Overview

This bash script modifies the Jellyfin web interface backdrop settings and creates an automatic backup of the original file. It is designed to work with Jellyfin running in a Docker container on Unraid.

## Prerequisites

- Unraid Server
- Jellyfin Docker Container
- Bash Shell
- Docker

## What Does This Script Do?

The script:
- Creates a timestamped backup of the original `main.jellyfin.bundle.js` file
- Stores backups in a local `backups/` directory
- Modifies the Jellyfin web bundle JavaScript file
- Changes the `enableBackdrops` function's return value

### Specific Modification
- Searches for `enableBackdrops:function(){return R}`
- Replaces it with `enableBackdrops:function(){return E}`

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/jellyfin-backdrop-modifier.git
   cd jellyfin-backdrop-modifier
   ```

2. Make the script executable:
   ```bash
   chmod +x jellyfin_modify.sh
   ```

## Usage

Run the script directly from its directory:
```bash
./jellyfin_modify.sh
```

### Backup Management

- Backups are automatically created in a `backups/` subdirectory
- Backup filename format: `main.jellyfin.bundle.js.backup_YYYYMMDD_HHMMSS`
- Previous backups are preserved, allowing you to revert changes if needed

### Restoration

To restore a backup:
```bash
# Example restoration (replace with your specific backup filename)
docker cp backups/main.jellyfin.bundle.js.backup_YYYYMMDD_HHMMSS jellyfin:/usr/share/jellyfin/web/main.jellyfin.bundle.js
```

### Customization

Before running, modify these variables:
- `CONTAINER_NAME`: Set to your Jellyfin Docker container name
- `FILE_PATH`: Confirm path to `main.jellyfin.bundle.js` inside the container

## Script Behavior

- Checks if the specified line exists in the file
- Creates a backup before any modifications
- Performs replacement only if the original line is found
- Provides detailed console output about the operation

## Error Handling

- Exits with an error if the replacement fails
- Provides feedback about backup creation and modification status
- Returns appropriate exit codes for scripting

## Caution

⚠️ **Warnings**: 
- Always review backups before making modifications
- Backup files are stored locally with the script
- Modifications might be overwritten during Jellyfin updates

## Backup Storage

- Backups are stored in a `backups/` directory
- Each backup is timestamped
- No automatic cleanup of old backups (manual management recommended)

## Compatibility

Tested with:
- Unraid
- Jellyfin Docker Container
- Bash 4.x and 5.x

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Open a Pull Request

## Troubleshooting

- Ensure Docker is running
- Verify container name matches your Jellyfin container
- Check file paths if modifications fail

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Support

For issues or questions, [open a GitHub issue](https://github.com/yourusername/jellyfin-backdrop-modifier/issues).

## Acknowledgments

- Jellyfin Community
- Unraid Users
