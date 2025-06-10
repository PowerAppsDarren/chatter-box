# Chatterbox TTS Docker Setup

This setup provides containerized development and deployment options for Chatterbox TTS.

## Prerequisites

- Docker and Docker Compose installed
- NVIDIA Docker runtime (for GPU support)
- At least 8GB of free disk space (for models)

## Quick Start

### 1. Build and Run (GPU)
```bash
# Build the containers
docker-compose build

# Start the main development container
docker-compose up chatterbox-tts

# Or start the Gradio web interface
docker-compose up chatterbox-gradio
```

### 2. CPU-Only Development
```bash
# For development without GPU
docker-compose up chatterbox-cpu
```

### 3. Interactive Development
```bash
# Enter the container for development
docker-compose run --rm chatterbox-tts bash

# Inside the container, you can run:
python example_tts.py
python gradio_tts_app.py
```

## Services

### `chatterbox-tts`
- Main development container with GPU support
- Interactive bash shell by default
- Volume mounted for live code editing

### `chatterbox-gradio`
- Web interface accessible at http://localhost:7860
- Automatically starts the Gradio app

### `chatterbox-cpu`
- CPU-only version for testing/development
- Accessible at http://localhost:7861

## Volumes

- `chatterbox-models`: Persistent storage for downloaded models
- `./output`: Local output directory for generated audio files
- `.:/app`: Live code mounting for development

## Development Workflow

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/chatterbox.git
   cd chatterbox
   ```

3. **Start development container**:
   ```bash
   docker-compose up chatterbox-tts
   ```

4. **Make changes** to the code (changes are reflected immediately due to volume mounting)

5. **Test your changes** inside the container:
   ```bash
   docker-compose exec chatterbox-tts python example_tts.py
   ```

## Environment Variables

- `CUDA_VISIBLE_DEVICES`: Control GPU visibility
- `HF_HOME`: Hugging Face cache directory
- `TRANSFORMERS_CACHE`: Transformers model cache
- `TORCH_HOME`: PyTorch model cache

## Troubleshooting

### GPU Issues
- Ensure NVIDIA Docker runtime is installed
- Check GPU availability: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`

### Memory Issues
- The models require significant RAM/VRAM
- Consider using CPU-only version for development
- Adjust Docker memory limits if needed

### Model Download Issues
- Models are downloaded on first run
- Ensure stable internet connection
- Models are cached in the `chatterbox-models` volume

## Customization

### Adding Dependencies
Edit `pyproject.toml` and rebuild:
```bash
docker-compose build --no-cache
```

### Custom Configuration
- Modify configs in `src/chatterbox/models/*/configs.py`
- Changes are reflected immediately due to volume mounting

### Different PyTorch Versions
Edit the base image in `Dockerfile`:
```dockerfile
FROM pytorch/pytorch:YOUR_VERSION
```

## Production Deployment

For production, consider:
1. Multi-stage builds to reduce image size
2. Non-root user for security
3. Health checks
4. Resource limits
5. Model preloading strategies
