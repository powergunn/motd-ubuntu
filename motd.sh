#!/bin/bash

# Path to the motd file
motd_file="/etc/motd"

# Path to the directory for disabled update-motd.d scripts
disabled_dir="/etc/update-motd.d-disabled"

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

# Remove the existing motd file if it exists
if [ -e "$motd_file" ]; then
    sudo rm "$motd_file"
fi

# Create a new motd file with the desired ASCII art
echo "$ascii_art" | sudo tee "$motd_file" > /dev/null

# Display success message
echo "File motd telah diperbarui dengan ASCII art yang diinginkan."

# Check if disabled_dir already exists, if not, create it
if [ ! -d "$disabled_dir" ]; then
    sudo mkdir "$disabled_dir"
fi

# Disable update-motd.d scripts if there are any
if [ "$(ls -A /etc/update-motd.d/)" ]; then
    sudo mv /etc/update-motd.d/* "$disabled_dir"/
    echo "Skrip di /etc/update-motd.d/ telah dinonaktifkan."
else
    echo "Tidak ada skrip di /etc/update-motd.d/ untuk dinonaktifkan."
fi
