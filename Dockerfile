# Stage 1: Build
FROM python:3.11-slim AS builder

WORKDIR /app
COPY app/ app/

# Install required system dependencies
RUN apt-get update && apt-get install -y binutils

# Install Python build tools
RUN pip install --upgrade pip && pip install pyinstaller

# Build the executable
RUN pyinstaller --onefile app/main.py

# Stage 2: Run
FROM debian:bullseye-slim

WORKDIR /app
COPY --from=builder /app/dist/main /app/main
ENTRYPOINT ["./main"]
