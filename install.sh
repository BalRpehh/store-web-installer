#!/data/data/com.termux/files/usr/bin/bash

# Warna untuk tampilan
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}==========================================${NC}"
echo -e "${GREEN}       WEB STORE AUTO INSTALLER          ${NC}"
echo -e "${CYAN}==========================================${NC}"

# 1. Nama Store
read -p "Apa nama store: " STORE_NAME

# 2. Pakasir Setup
read -p "Auto setup pakasir? (yes/no): " SETUP_PAKASIR
if [[ $SETUP_PAKASIR == "yes" ]]; then
    read -p "Masukkan API Pakasir: " API_PAKASIR
fi

# 3. Item & Harga
read -p "Berapa banyak item yang dijual: " JML_ITEM
declare -a HARGA_ITEMS
for ((i=1; i<=JML_ITEM; i++)); do
    read -p "Harga item ke-$i: " HARGA
    HARGA_ITEMS+=("$HARGA")
done

# 4. Support Chat
read -p "Support chat (Contoh: Wa.me/628xxx): " SUPPORT_CHAT

# 5. Firebase Setup
read -p "Sistem login? (yes/no): " LOGIN_SYSTEM
if [[ $LOGIN_SYSTEM == "yes" ]]; then
    echo -e "${CYAN}--- Masukkan Detail Firebase ---${NC}"
    read -p "Firebase API Key: " FB_API
    read -p "Firebase Project ID: " FB_ID
    read -p "Firebase Messaging Sender ID: " FB_SENDER
fi

# --- PROSES PEMBUATAN FILE KONFIGURASI ---
echo -e "\n${GREEN}Sedang menyusun konfigurasi...${NC}"

# Membuat file .env atau config.json
cat <<EOF > config.env
STORE_NAME="$STORE_NAME"
API_PAKASIR="$API_PAKASIR"
TOTAL_ITEMS="$JML_ITEM"
ITEM_PRICES="${HARGA_ITEMS[*]}"
SUPPORT_LINK="$SUPPORT_CHAT"
FB_API_KEY="$FB_API"
FB_PROJECT_ID="$FB_ID"
FB_SENDER_ID="$FB_SENDER"
EOF

echo -e "${GREEN}Setup Selesai! File 'config.env' telah dibuat.${NC}"
echo -e "Sekarang jalankan perintah web store kamu (misal: npm start)"

