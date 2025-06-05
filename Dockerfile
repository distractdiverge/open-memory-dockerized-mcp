# Build stage
FROM python:3.11-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone and build OpenMemory
RUN git clone --depth 1 https://github.com/mem0ai/mem0.git /app/openmemory && \
    cd /app/openmemory && \
    pip install --no-cache-dir . && \
    pip wheel . -w /wheels

# Production stage
FROM python:3.11-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# Copy wheels and install
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir /wheels/*

# Expose the ports
EXPOSE 8000

# Default command to run the application
CMD ["python", "-m", "openmemory"]
