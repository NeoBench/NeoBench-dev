#!/bin/bash

# Ensure you're in the root of the neobench-dev workspace
cd "$(dirname "$0")"

# Ensure target spec exists
TARGET_JSON="targets/neobench-m68k.json"
if [ ! -f "$TARGET_JSON" ]; then
  echo "Error: $TARGET_JSON does not exist"
  exit 1
fi

# Check for rust-src
if ! rustup +nightly-2024-06-01 component list | grep 'rust-src.*installed' > /dev/null; then
  echo "Adding rust-src component..."
  rustup +nightly-2024-06-01 component add rust-src || {
    echo "Failed to add rust-src"
    exit 1
  }
fi

# Clean and build
echo "[*] Cleaning previous build..."
cargo +nightly-2024-06-01 clean

echo "[*] Building NeoBench for m68k..."
cargo +nightly-2024-06-01 build \
  -Z build-std=core,compiler_builtins \
  -Z build-std-features=compiler-builtins-mem \
  --target $TARGET_JSON \
  --release

if [ $? -eq 0 ]; then
  echo "[✓] Build successful."
else
  echo "[✗] Build failed."
fi
