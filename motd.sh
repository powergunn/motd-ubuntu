#!/bin/bash

# Path to the motd file
motd_file="/etc/motd"

# Your desired ASCII art
ascii_art=$(cat << "EOF"
 _____                        _____                   
|  __ \                      / ____|                  
| |__) |____      _____ _ __| |  __ _   _ _ __  _ __  
|  ___/ _ \ \ /\ / / _ \ '__| | |_ | | | | '_ \| '_ \ 
| |  | (_) \ V  V /  __/ |  | |__| | |_| | | | | | | |
|_|   \___/ \_/\_/ \___|_|   \_____|\__,_|_| |_|_| |_|
EOF
)

# Check if the motd file exists
if [ -e "$motd_file" ]; then
    # Backup the current motd file
    mv "$motd_file" "$motd_file.bak"
fi

# Create a new motd file with the desired ASCII art
echo "$ascii_art" | sudo tee "$motd_file"

# Display success message
echo "The motd file has been updated with the custom ASCII art."
