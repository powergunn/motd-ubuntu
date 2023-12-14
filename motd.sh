#!/bin/bash

# Mendeteksi sistem operasi
os=$(uname -s)

# Path menuju file motd
motd_file="/etc/motd"

# Path menuju direktori untuk skrip update-motd.d yang dinonaktifkan
disabled_dir="/etc/update-motd.d-disabled"

# ASCII art yang diinginkan
ascii_art=$(cat << "EOF"
 _____                        _____                   
|  __ \                      / ____|                  
| |__) |____      _____ _ __| |  __ _   _ _ __  _ __  
|  ___/ _ \ \ /\ / / _ \ '__| | |_ | | | | '_ \| '_ \ 
| |  | (_) \ V  V /  __/ |  | |__| | |_| | | | | | | |
|_|   \___/ \_/\_/ \___|_|   \_____|\__,_|_| |_|_| |_|
EOF
)

# Fungsi untuk menonaktifkan skrip update-motd.d
nonaktifkan_skrip_update_motd() {
    if [ "$(ls -A /etc/update-motd.d/)" ]; then
        sudo mv /etc/update-motd.d/* "$disabled_dir"/
        echo "Skrip di /etc/update-motd.d/ telah dinonaktifkan."
    else
        echo "Tidak ada skrip di /etc/update-motd.d/ untuk dinonaktifkan."
    fi
}

# Menghapus file motd yang sudah ada jika ada
if [ -e "$motd_file" ]; then
    sudo rm "$motd_file"
fi

# Membuat file motd baru dengan ASCII art yang diinginkan
echo "$ascii_art" | sudo tee "$motd_file" > /dev/null

# Menampilkan pesan keberhasilan
echo "File motd telah diperbarui dengan ASCII art yang diinginkan."

# Memeriksa sistem operasi untuk menangani skrip update-motd.d
case "$os" in
    Linux*)
        # Memeriksa apakah disabled_dir sudah ada, jika tidak, membuatnya
        if [ ! -d "$disabled_dir" ]; then
            sudo mkdir "$disabled_dir"
        fi
        nonaktifkan_skrip_update_motd
        ;;
    *)
        echo "Sistem operasi tidak dikenal atau tidak mendukung operasi ini."
        ;;
esac
