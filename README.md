# OpenMemory Docker Image

This repository contains a Dockerfile to build and run the OpenMemory service in a containerized environment. OpenMemory is a memory layer for AI applications that enables persistent memory across sessions.

## Prerequisites

- Docker installed on your system
- An OpenAI API key (or other supported LLM provider key)

## Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```bash
docker build -t openmemory .
```

## Running the Container

### Basic Usage

```bash
docker run -d -p 8000:8000 openmemory
```

### Setting Environment Variables

You can configure OpenMemory using environment variables. The most important one is your OpenAI API key:

```bash
docker run -d \
  -p 8000:8000 \
  -e OPENAI_API_KEY=your-api-key-here \
  openmemory
```

### Mounting Persistent Storage

To persist memory data between container restarts, mount a volume to `/app/data`:

```bash
docker run -d \
  -p 8000:8000 \
  -e OPENAI_API_KEY=your-api-key-here \
  -v openmemory_data:/app/data \
  openmemory
```

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `OPENAI_API_KEY` | Your OpenAI API key | Yes | - |
| `PORT` | Port to run the server on | No | 8000 |
| `LOG_LEVEL` | Logging level (DEBUG, INFO, WARNING, ERROR) | No | INFO |
| `MEMORY_STORE_PATH` | Path to store memory data | No | /app/data |

## Using the API

Once running, the OpenMemory API will be available at `http://localhost:8000`.

Example API request:

```bash
curl -X POST http://localhost:8000/api/memory \
  -H "Content-Type: application/json" \
  -d '{"text": "User prefers dark mode"}'
```

## Stopping the Container

To stop the container:

```bash
docker stop $(docker ps -q --filter ancestor=openmemory)
```

## Troubleshooting

- If you encounter permission issues with the data volume, ensure the container has write permissions to the mounted directory
- Check container logs with `docker logs <container_id>`
- For debugging, you can run the container in interactive mode with `docker run -it openmemory /bin/bash`
