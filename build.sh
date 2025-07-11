#!/bin/bash
set -e

TARGET_DIR="targets"
TARGET_FILE="$TARGET_DIR/neobench-m68k.json"

echo "Creating target file: $TARGET_FILE"

mkdir -p "$TARGET_DIR"

cat > "$TARGET_FILE" <<EOF
{
  "llvm-target": "m68k-unknown-none",
  "arch": "m68k",
  "os": "none",
  "vendor": "unknown",
  "cpu": "m68060",
  "data-layout": "E-m:e-p:32:16:32-i8:8:8-i16:16:16-i32:16:32-n8:16:32-a:0:16-S16",
  "linker-flavor": "ld.lld",
  "disable-redzone": true,
  "executables": true,
  "linker": "m68k-elf-ld",
  "no-compiler-rt": true,
  "panic-strategy": "abort",
  "relocation-model": "static",
  "target-endian": "big",
  "target-pointer-width": "32",
  "target-c-int-width": "32",
  "features": "+68060,+fpu,+mmu",
  "abi-blacklist": []
}
EOF

echo "Target file generated successfully."

echo "Cleaning previous build..."
cargo clean

echo "Starting NeoBench build..."
cargo +nightly-2024-06-01 build \
  -Z build-std=core,compiler_builtins \
  --target "$TARGET_FILE" \
  --release
