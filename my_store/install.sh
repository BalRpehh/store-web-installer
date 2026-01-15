#!/data/data/com.termux/files/usr/bin/bash

# Fix PHP Permission Denied di Termux
export PHP_INI_SCAN_DIR=$PHP_INI_SCAN_DIR
mkdir -p $HOME/.php
echo "session.save_path = \"/data/data/com.termux/files/usr/tmp\"" > $HOME/.php/php.ini

clear
echo "=========================================="
echo "       WEB STORE SETUP WIZARD            "
echo "=========================================="

# Memastikan terminal menerima input (interaktif)
exec < /dev/tty

# --- INPUT DATA STORE ---
read -p "Apa nama store: " STORE_NAME
read -p "Auto setup Pakasir? (yes/no): " SETUP_PAKASIR
if [[ $SETUP_PAKASIR == "yes" ]]; then
    read -p "Masukkan API Pakasir: " API_PAKASIR
fi

read -p "Berapa banyak item yang dijual: " JML_ITEM
read -p "Support chat (Contoh: Wa.me/628xxx): " SUPPORT_CHAT
read -p "Sistem login Firebase? (yes/no): " LOGIN_SYSTEM

# --- INPUT VERCEL ---
read -p "Mau setup Vercel? (yes/no): " SETUP_VERCEL
if [[ $SETUP_VERCEL == "yes" ]]; then
    read -p "Masukkan Nama Domain Vercel (contoh: tokoku.vercel.app): " VERCEL_DOMAIN
    echo -e "\n* Catatan: Untuk deploy ke ichessjava@gmail.com, kamu harus login nanti."
fi

echo -e "\n[1/4] Memasang Dependencies..."
pkg install php nodejs -y

if [[ $SETUP_VERCEL == "yes" ]]; then
    echo "Memasang Vercel CLI..."
    npm install -g vercel
fi

echo "[2/4] Mendownload Template..."
mkdir -p my_store
cd my_store

# Download template dari repo kamu
curl -sL "https://raw.githubusercontent.com/BalRpehh/store-web-installer/main/index.html?v=$(date +%s)" -o index.html

echo "[3/4] Mengonfigurasi Website..."
sed -i "s|{{STORE_NAME}}|$STORE_NAME|g" index.html
sed -i "s|{{SUPPORT_CHAT}}|$SUPPORT_CHAT|g" index.html

# Jika milih Vercel, kita buat file vercel.json untuk set domain
if [[ $SETUP_VERCEL == "yes" ]]; then
    cat <<EOF > vercel.json
{
  "name": "$STORE_NAME",
  "alias": "$VERCEL_DOMAIN"
}
EOF
fi

echo "=========================================="
echo "      INSTALLASI BERHASIL!"
echo "=========================================="

if [[ $SETUP_VERCEL == "yes" ]]; then
    echo "Langkah Deploy ke Vercel:"
    echo "1. Ketik: vercel login (Masukkan email: ichessjava@gmail.com)"
    echo "2. Ketik: vercel --prod (Untuk deploy ke domain $VERCEL_DOMAIN)"
    echo "------------------------------------------"
fi

echo "Untuk menjalankan lokal di Termux:"
echo "cd my_store && php -c $HOME/.php/php.ini -S 127.0.0.1:8080"
