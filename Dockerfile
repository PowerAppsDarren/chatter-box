# Use Python 3.11 with CUDA support
FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsndfile1 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY pyproject.toml ./

# Install Python dependencies
RUN pip install --no-cache-dir -e .

# Copy the entire project
COPY . .

# Install the package in development mode
RUN pip install -e .

# Create directories for model cache and output
RUN mkdir -p /app/models /app/output

# Set environment variables
ENV PYTHONPATH=/app
ENV HF_HOME=/app/models
ENV TRANSFORMERS_CACHE=/app/models
ENV TORCH_HOME=/app/models

# Expose port for potential web interface
EXPOSE 7860

# Default command
CMD ["python", "example_tts.py"]
