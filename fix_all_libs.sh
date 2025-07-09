#!/bin/bash
set -e

for crate in boot kernel gui fs shell drivers startup; do
  cat > src/$crate/src/lib.rs <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn _start_${crate}() -> ! {
    loop {}
}
EOF
done
