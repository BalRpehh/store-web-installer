#!/data/data/com.termux/files/usr/bin/bash

# Warna
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}==========================================${NC}"
echo -e "${GREEN}       INSTALLING WEB STORE...           ${NC}"
echo -e "${CYAN}==========================================${NC}"

# 1. Ambil Input (Sama seperti sebelumnya)
read -p "Apa nama store: " STORE_NAME
read -p "Auto setup Pakasir? (yes/no): " SETUP_PAKASIR
if [[ $SETUP_PAKASIR == "yes" ]]; then
    read -p "Masukkan API Pakasir: " API_PAKASIR
fi
read -p "Berapa banyak item yang dijual: " JML_ITEM
read -p "Support chat (Contoh: Wa.me/628xxx): " SUPPORT_CHAT
read -p "Sistem login Firebase? (yes/no): " LOGIN_SYSTEM

# 2. Install Dependencies (Web Server sederhana)
echo -e "\n${CYAN}[1/3] Memasang Dependencies...${NC}"
pkg install php -y  # Kita pakai PHP untuk server lokal yang ringan

# 3. Download Template Website
echo -e "${CYAN}[2/3] Mendownload file HTML/CSS/JS...${NC}"
# Kita buat folder store
mkdir -p my_store
cd my_store

# Download file HTML (Template)
curl -O https://raw.githubusercontent.com/BalRpehh/store-web-installer/main/index.html

# 4. Inject data user ke dalam file HTML (Otomatisasi)
echo -e "${CYAN}[3/3] Mengonfigurasi Web Store...${NC}"

# Mengganti placeholder di index.html dengan input user menggunakan 'sed'
sed -i "s/{{STORE_NAME}}/$STORE_NAME/g" index.html
sed -i "s|{{SUPPORT_CHAT}}|$SUPPORT_CHAT|g" index.html

echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}      INSTALLASI BERHASIL!               ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "Silakan jalankan perintah ini untuk buka store:"
echo -e "${CYAN}cd my_store && php -S localhost:8080${NC}"
echo -e "Lalu buka browser di: http://localhost:8080"

