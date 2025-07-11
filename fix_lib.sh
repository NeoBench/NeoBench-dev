#!/bin/bash

set -e

BASE_DIR="src"
MODULES=("boot" "kernel" "gui" "fs" "drivers" "startup")

for MODULE in "${MODULES[@]}"; do
    LIB_PATH="$BASE_DIR/$MODULE/src/lib.rs"

    mkdir -p "$(dirname "$LIB_PATH")"

    cat > "$LIB_PATH" <<EOF
#![no_std]

#[no_mangle]
pub extern "C" fn ${MODULE}_main() {
    // TODO: Implement ${MODULE}
}
EOF

    echo "✔ Rewritten $LIB_PATH"
done
