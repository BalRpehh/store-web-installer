#!/data/data/com.termux/files/usr/bin/bash

# Variabel Warna
G='\033[0;32m'
C='\033[0;36m'
Y='\033[0;33m'
R='\033[0;31m'
NC='\033[0m'

# Pastikan terminal bisa menerima input
exec < /dev/tty

function header() {
    clear
    echo -e "${C}==========================================${NC}"
    echo -e "${G}         BALRPEHH TERMUX TOOLBOX          ${NC}"
    echo -e "${C}==========================================${NC}"
}

function main_menu() {
    header
    echo -e "${Y}[ MENU UTAMA ]${NC}"
    echo -e "1) Install Paket Dasar (Git, Python, PHP, Nano)"
    echo -e "2) Ganti Tampilan Termux (Custom Banner)"
    echo -e "3) Download Video (YouTube/TikTok/IG)"
    echo -e "4) Bersihkan Sampah Sistem (Cache)"
    echo -e "5) Cek Informasi HP & Jaringan"
    echo -e "0) Keluar"
    echo -e "${C}------------------------------------------${NC}"
    read -p "Pilih opsi (0-5): " opt

    case $opt in
        1) install_basics ;;
        2) setup_dashboard ;;
        3) download_video ;;
        4) clean_system ;;
        5) info_system ;;
        0) exit 0 ;;
        *) echo -e "${R}Pilihan tidak valid!${NC}"; sleep 1; main_menu ;;
    esac
}

function install_basics() {
    echo -e "\n${Y}Sedang menginstall paket dasar...${NC}"
    pkg update && pkg upgrade -y
    pkg install git python php nano curl wget figlet -y
    echo -e "${G}Selesai!${NC}"
    sleep 2; main_menu
}

function setup_dashboard() {
    read -p "Masukkan nama untuk Banner: " NAMA_BANNER
    echo "figlet -f slant \"$NAMA_BANNER\" | lolcat" > $HOME/.bashrc
    echo "echo -e \"Selamat Datang di Termux, $NAMA_BANNER!\"" >> $HOME/.bashrc
    echo "echo -e \"--------------------------------------\"" >> $HOME/.bashrc
    pkg install lolcat -y
    echo -e "${G}Tampilan berhasil diganti! Mulai ulang Termux untuk melihat perubahan.${NC}"
    sleep 3; main_menu
}

function download_video() {
    echo -e "\n${Y}Memasang downloader (yt-dlp)...${NC}"
    pkg install python -y
    pip install yt-dlp
    read -p "Masukkan Link Video: " LINK
    mkdir -p /sdcard/Download/Toolbox
    yt-dlp -o "/sdcard/Download/Toolbox/%(title)s.%(ext)s" "$LINK"
    echo -e "${G}Video berhasil didownload ke folder /Download/Toolbox${NC}"
    sleep 3; main_menu
}

function clean_system() {
    echo -e "\n${Y}Membersihkan sampah...${NC}"
    apt autoremove -y && apt clean
    echo -e "${G}Sistem bersih!${NC}"
    sleep 2; main_menu
}

function info_system() {
    header
    echo -e "${Y}--- INFO PERANGKAT ---${NC}"
    echo -e "Model: $(getprop ro.product.model)"
    echo -e "Android: $(getprop ro.build.version.release)"
    echo -e "Uptime: $(uptime -p)"
    echo -e "\n${Y}--- INFO JARINGAN ---${NC}"
    ip addr show | grep 'inet ' | grep -v '127.0.0.1'
    echo -e "\nTekan Enter untuk kembali..."
    read
    main_menu
}

# Mulai aplikasi
main_menu
