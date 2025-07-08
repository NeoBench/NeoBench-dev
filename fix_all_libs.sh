#!/bin/bash

echo "🔧 Fixing all lib.rs files under src/*/src..."

for file in src/*/src/lib.rs; do
    if [ -f "$file" ]; then
        echo "→ Updating $file"
        cat > "$file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn _start() -> ! {
    loop {}
}
EOF
    fi
done

echo "✅ All lib.rs files updated."
