#!/bin/bash

set -e

echo "=============================="
echo " NeoBench Build Script"
echo "=============================="

TARGET_JSON="targets/neobench-m68k.json"
NIGHTLY="nightly-2024-06-01"

# [1] Check for required target JSON
if [[ ! -f "$TARGET_JSON" ]]; then
  echo "❌ ERROR: $TARGET_JSON not found!"
  echo "Create it with the correct layout before continuing."
  exit 1
fi

# [2] Ensure correct toolchain
echo "🔧 Installing Rust nightly $NIGHTLY if missing..."
rustup install "$NIGHTLY"
rustup component add rust-src --toolchain "$NIGHTLY"

# [3] Update git submodules
echo "📥 Updating Git submodules..."
git submodule update --init --recursive

# [4] Clean build output
echo "🧹 Cleaning old build..."
cargo clean

# [5] Check for invalid manifest structure
if grep -q '\[dependencies\]' Cargo.toml && grep -q '\[workspace\]' Cargo.toml; then
  echo "⚠️ WARNING: Virtual manifest includes [dependencies], which is invalid!"
fi

# [6] Update crate index
echo "📦 Updating Cargo crates..."
cargo update

# [7] Build everything
echo "🚧 Starting build for $TARGET_JSON..."
RUSTFLAGS="--cfg compiler_builtins_no_mem" \
cargo +"$NIGHTLY" build \
  -Z build-std=core,compiler_builtins \
  --target "$TARGET_JSON" \
  --release

echo "✅ Build finished successfully!"

# [8] Show target spec (optional)
echo "📋 Target spec dump:"
rustc +"$NIGHTLY" -Z unstable-options --print target-spec-json --target "$TARGET_JSON" | jq '.'
