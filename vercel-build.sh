#!/bin/bash
# Vercel Custom Build Script for Flutter Web

# Exit immediately if a command exits with a non-zero status
set -e

# Print executing commands
set -x

echo "=== Installing Flutter SDK ==="
# Download Flutter SDK (Linux stable release)
FLUTTER_VERSION="3.19.6"
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

# Export Flutter executable path
export PATH="$PATH:$(pwd)/flutter/bin"

echo "=== Config Flutter ==="
flutter config --no-analytics
flutter config --enable-web

echo "=== Get Dependencies ==="
flutter pub get

echo "=== Compiling Flutter Web Application ==="
flutter build web --release

echo "=== Verification ==="
ls -la build/web

echo "=== Build Completed ==="
