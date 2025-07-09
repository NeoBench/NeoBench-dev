#!/bin/bash
set -e

echo "🔧 Updating entrypoints with correct #[no_mangle] usage..."

declare -A ENTRYPOINTS=(
  [boot]=_start_boot
  [drivers]=_start_drivers
  [fs]=_start_fs
  [gui]=_start_gui
  [kernel]=_start_kernel
  [shell]=_start_shell
  [startup]=_start_startup
)

for dir in "${!ENTRYPOINTS[@]}"; do
  target_file="src/$dir/src/lib.rs"
  symbol="${ENTRYPOINTS[$dir]}"

  echo "→ Updating $target_file"

  cat > "$target_file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $symbol() -> ! {
    loop {}
}
EOF

done

echo "✅ All lib.rs files updated with correct entrypoints."
