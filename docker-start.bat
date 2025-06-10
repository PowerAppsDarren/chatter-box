@echo off
REM Chatterbox TTS Docker Startup Script for Windows

echo 🎙️ Chatterbox TTS Docker Setup
echo ================================

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    exit /b 1
)

REM Check for NVIDIA Docker support
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ NVIDIA Docker support detected
    set USE_GPU=true
) else (
    echo ⚠️ No NVIDIA Docker support. Using CPU-only mode.
    set USE_GPU=false
)

echo.
echo Available options:
echo 1. Build containers
echo 2. Start development environment (interactive shell)
echo 3. Start Gradio web interface
echo 4. Run TTS example
echo 5. Clean up containers and volumes
echo.

set /p choice="Choose an option (1-5): "

if "%choice%"=="1" (
    echo 🔨 Building containers...
    docker-compose build
    echo ✅ Containers built successfully
) else if "%choice%"=="2" (
    echo 🚀 Starting development environment...
    if "%USE_GPU%"=="true" (
        docker-compose run --rm chatterbox-tts bash
    ) else (
        docker-compose run --rm chatterbox-cpu bash
    )
) else if "%choice%"=="3" (
    echo 🌐 Starting Gradio web interface...
    echo 📍 Access at: http://localhost:7860
    if "%USE_GPU%"=="true" (
        docker-compose up chatterbox-gradio
    ) else (
        echo Starting CPU version at http://localhost:7861
        docker-compose up chatterbox-cpu
    )
) else if "%choice%"=="4" (
    echo 🎵 Running TTS example...
    if "%USE_GPU%"=="true" (
        docker-compose run --rm chatterbox-tts python example_tts.py
    ) else (
        docker-compose run --rm chatterbox-cpu python example_tts.py
    )
    echo ✅ Check ./output/ directory for generated audio
) else if "%choice%"=="5" (
    echo 🧹 Cleaning up...
    docker-compose down -v
    docker system prune -f
    echo ✅ Cleanup completed
) else (
    echo ❌ Invalid option
    exit /b 1
)
