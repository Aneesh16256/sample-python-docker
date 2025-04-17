# Stage 1: Build
FROM python:3.11-slim AS builder

WORKDIR /app
COPY app/ app/
RUN pip install --upgrade pip && pip install pyinstaller
RUN pyinstaller --onefile app/main.py

# Stage 2: Run
FROM debian:bullseye-slim

WORKDIR /app
COPY --from=builder /dist/main /app/main
ENTRYPOINT ["./main"]
