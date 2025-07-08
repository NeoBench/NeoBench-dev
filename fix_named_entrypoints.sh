#!/bin/bash

declare -A entries=(
  [boot]=_start_boot
  [fs]=_start_fs
  [gui]=_start_gui
  [shell]=_start_shell
  [kernel]=_start_kernel
  [drivers]=_start_drivers
  [startup]=_start_startup
)

for crate in "${!entries[@]}"; do
  file="src/$crate/src/lib.rs"
  entry="${entries[$crate]}"
  if [ -f "$file" ]; then
    echo "→ Updating $file"
    cat > "$file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $entry() -> ! {
    loop {}
}
EOF
  fi
done

echo "✅ All lib.rs files updated with named _start functions."
