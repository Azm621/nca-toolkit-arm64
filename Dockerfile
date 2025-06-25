# Base image with Python 3.10 (ARM64 compatible)
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the NCA Toolkit source code
RUN git clone https://github.com/stephengpope/no-code-architects-toolkit.git /app

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Expose port
EXPOSE 8080

# Set environment variable for storage
ENV LOCAL_STORAGE_PATH=/tmp

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
