#!/data/data/com.termux/files/usr/bin/bash

# Warna
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

clear
echo -e "${CYAN}==========================================${NC}"
echo -e "${GREEN}       WEB STORE SETUP WIZARD            ${NC}"
echo -e "${CYAN}==========================================${NC}"

# --- INPUT USER ---
read -p "Apa nama store: " STORE_NAME
read -p "Auto setup Pakasir? (yes/no): " SETUP_PAKASIR
if [[ $SETUP_PAKASIR == "yes" ]]; then
    read -p "Masukkan API Pakasir: " API_PAKASIR
fi

read -p "Berapa banyak item yang dijual: " JML_ITEM
read -p "Harga masing-masing item (pisahkan dengan koma): " HARGA_ITEMS
read -p "Support chat (Contoh: Wa.me/628xxx): " SUPPORT_CHAT
read -p "Sistem login Firebase? (yes/no): " LOGIN_SYSTEM
read -p "Mau setup Vercel untuk hosting? (yes/no): " SETUP_VERCEL

# --- INSTALL DEPENDENCIES ---
echo -e "\n${CYAN}[1/4] Memasang Dependencies...${NC}"
pkg install php nodejs -y 

if [[ $SETUP_VERCEL == "yes" ]]; then
    echo -e "${YELLOW}Memasang Vercel CLI...${NC}"
    npm install -g vercel
fi

# --- DOWNLOAD & CONFIG ---
echo -e "${CYAN}[2/4] Mendownload Template Website...${NC}"
mkdir -p my_store
cd my_store

# Ambil index.html (Tambahkan cache-buster agar selalu fresh)
curl -sL "https://raw.githubusercontent.com/BalRpehh/store-web-installer/main/index.html?v=$(date +%s)" -o index.html

echo -e "${CYAN}[3/4] Mengonfigurasi Web Store...${NC}"

# Menggunakan karakter '|' sebagai pemisah sed agar aman dari link "/"
sed -i "s|{{STORE_NAME}}|$STORE_NAME|g" index.html
sed -i "s|{{SUPPORT_CHAT}}|$SUPPORT_CHAT|g" index.html

# --- FINISHING ---
echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}      INSTALLASI BERHASIL!               ${NC}"
echo -e "${GREEN}==========================================${NC}"

if [[ $SETUP_VERCEL == "yes" ]]; then
    echo -e "${YELLOW}Untuk deploy ke Vercel, ketik: ${CYAN}vercel${NC}"
fi

echo -e "\nUntuk menjalankan lokal di Termux:"
echo -e "${CYAN}php -S 127.0.0.1:8080${NC}"
echo -e "Lalu buka browser: http://localhost:8080"
