#!/bin/bash

# Chatterbox TTS Docker Startup Script

set -e

echo "🎙️ Chatterbox TTS Docker Setup"
echo "================================"

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check for NVIDIA Docker support
if docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi >/dev/null 2>&1; then
    echo "✅ NVIDIA Docker support detected"
    USE_GPU=true
else
    echo "⚠️ No NVIDIA Docker support. Using CPU-only mode."
    USE_GPU=false
fi

echo ""
echo "Available options:"
echo "1. Build containers"
echo "2. Start development environment (interactive shell)"
echo "3. Start Gradio web interface"
echo "4. Run TTS example"
echo "5. Clean up containers and volumes"
echo ""

read -p "Choose an option (1-5): " choice

case $choice in
    1)
        echo "🔨 Building containers..."
        docker-compose build
        echo "✅ Containers built successfully"
        ;;
    2)
        echo "🚀 Starting development environment..."
        if [ "$USE_GPU" = true ]; then
            docker-compose run --rm chatterbox-tts bash
        else
            docker-compose run --rm chatterbox-cpu bash
        fi
        ;;
    3)
        echo "🌐 Starting Gradio web interface..."
        echo "📍 Access at: http://localhost:7860"
        if [ "$USE_GPU" = true ]; then
            docker-compose up chatterbox-gradio
        else
            echo "Starting CPU version at http://localhost:7861"
            docker-compose up chatterbox-cpu
        fi
        ;;
    4)
        echo "🎵 Running TTS example..."
        if [ "$USE_GPU" = true ]; then
            docker-compose run --rm chatterbox-tts python example_tts.py
        else
            docker-compose run --rm chatterbox-cpu python example_tts.py
        fi
        echo "✅ Check ./output/ directory for generated audio"
        ;;
    5)
        echo "🧹 Cleaning up..."
        docker-compose down -v
        docker system prune -f
        echo "✅ Cleanup completed"
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac
