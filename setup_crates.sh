#!/bin/bash
set -e

echo "📦 Creating NeoBench Rust crates..."

CRATES=(boot kernel shell gui fs drivers startup)
for name in "${CRATES[@]}"; do
  cargo new --lib "src/$name" --vcs none
  echo "#![no_std]
#![no_main]

#[no_mangle]
pub extern \"C\" fn _start() -> ! {
    loop {}
}" > "src/$name/src/lib.rs"
done

cat > Cargo.toml <<EOF
[workspace]
members = [
    "src/boot",
    "src/kernel",
    "src/shell",
    "src/gui",
    "src/fs",
    "src/drivers",
    "src/startup"
]
EOF

echo "✅ Rust workspace ready."
