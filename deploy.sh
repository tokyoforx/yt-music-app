# ========================================
# YouTube Music App - Auto Deployment Script
# Frontend: React + Vite (port 3030)
# Backend:  FastAPI (port 5050)
# ========================================

APP_DIR="$HOME/yt-music-app"
FRONTEND_DIR="$APP_DIR/client"
BACKEND_DIR="$APP_DIR/server"
PORT_BACKEND=5050
PORT_FRONTEND=3030

echo "🛠️ Membuat folder yt-dlp cache..."
mkdir -p "$APP_DIR/yt-dlp"

echo "🎨 [1/3] Build Frontend (port $PORT_FRONTEND)..."
cd "$FRONTEND_DIR"
npm install
npm run build

echo "🐍 [2/3] Setup Backend..."
cd "$BACKEND_DIR"
pip install -r "$APP_DIR/requirements.txt"

echo "💀 [3/3] Matikan proses lama..."
pkill -f "uvicorn main:app" 2>/dev/null || true
pkill -f "vite preview" 2>/dev/null || true

echo "🚀 Menjalankan FastAPI di port $PORT_BACKEND..."
nohup uvicorn main:app --host 0.0.0.0 --port $PORT_BACKEND > "$APP_DIR/fastapi.log" 2>&1 &

echo "🌐 Menjalankan Vite Preview (frontend) di port $PORT_FRONTEND..."
cd "$FRONTEND_DIR"
nohup npm run serve -- --port $PORT_FRONTEND > "$APP_DIR/frontend.log" 2>&1 &

echo "✅ Deployment selesai!"
echo "🔗 Frontend: http://localhost:$PORT_FRONTEND"
echo "🔗 Backend:  http://localhost:$PORT_BACKEND/api"
