#!/bin/bash

# NeoBench Build Script (regenerated)
# Assumes you're inside ~/neobench-dev

# Set variables
TARGET_JSON="targets/neobench-m68k.json"
NIGHTLY_DATE="2024-06-01"
RELEASE_FLAG="--release"

# Check for the correct Rust nightly toolchain
echo "[*] Using Rust nightly toolchain: $NIGHTLY_DATE"
rustup override set nightly-$NIGHTLY_DATE

# Check if target JSON exists
if [ ! -f "$TARGET_JSON" ]; then
    echo "[!] Target JSON not found at $TARGET_JSON"
    exit 1
fi

# Clean old build
echo "[*] Cleaning old build..."
cargo clean

# Run the build
echo "[*] Starting build..."
cargo +nightly-$NIGHTLY_DATE build \
  -Z build-std=core,compiler_builtins \
  --target $TARGET_JSON \
  $RELEASE_FLAG

# Check result
if [ $? -eq 0 ]; then
    echo "[✓] NeoBench build complete."
else
    echo "[✗] Build failed."
fi
