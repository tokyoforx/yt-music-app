# ========================================
# Reset Script untuk yt-music-app
# Menghentikan semua proses + hapus log + bersih build
# ========================================

APP_DIR="$HOME/yt-music-app"
FRONTEND_DIR="$APP_DIR/client"
BACKEND_DIR="$APP_DIR/server"

echo "🛑 Menghentikan proses FastAPI (uvicorn)..."
pkill -f "uvicorn main:app" 2>/dev/null && echo "✅ FastAPI dihentikan" || echo "ℹ️ Tidak ditemukan"

echo "🛑 Menghentikan proses Vite Preview..."
pkill -f "vite preview" 2>/dev/null && echo "✅ Vite dihentikan" || echo "ℹ️ Tidak ditemukan"

echo "🧹 Menghapus file log..."
rm -f "$APP_DIR/fastapi.log"
rm -f "$APP_DIR/frontend.log"

echo "🧹 Menghapus hasil build frontend (client/dist)..."
rm -rf "$FRONTEND_DIR/dist"

echo "✅ Reset selesai. Semua proses dimatikan dan file sementara dibersihkan."
