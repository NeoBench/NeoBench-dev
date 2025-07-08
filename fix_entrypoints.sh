#!/bin/bash

echo "🔧 Fixing all lib.rs entrypoints..."

for crate in src/*; do
  name=$(basename "$crate")
  file="$crate/src/lib.rs"
  if [[ -f "$file" ]]; then
    echo "→ Updating $file"
    cat > "$file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn _start_${name}() -> ! {
    loop {}
}
EOF
  fi
done

echo "✅ All lib.rs files updated with correct function syntax."
