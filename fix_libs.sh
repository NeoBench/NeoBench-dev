#!/bin/bash

echo "Fixing all lib.rs files in src/*/src..."

for dir in src/*/src; do
    if [ -d "$dir" ]; then
        file="$dir/lib.rs"
        if [ -f "$file" ]; then
            echo "Fixing $file"
            cat > "$file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn _start() -> ! {
    loop {}
}
EOF
        fi
    fi
done

echo "All lib.rs files have been reset."
