#!/bin/bash

declare -A FUNCTIONS=(
  [boot]=_start_boot
  [kernel]=_start_kernel
  [fs]=_start_fs
  [gui]=_start_gui
  [shell]=_start_shell
  [startup]=_start_startup
  [drivers]=_start_drivers
)

for crate in "${!FUNCTIONS[@]}"; do
  file="src/$crate/src/lib.rs"
  func="${FUNCTIONS[$crate]}"
  echo "→ Rewriting $file"

  mkdir -p "$(dirname "$file")"
  cat > "$file" <<EOF2
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $func() -> ! {
    loop {}
}
EOF2
done

echo "✅ All lib.rs entry points now valid."
