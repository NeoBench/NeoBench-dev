#!/bin/bash

set -e

echo "📁 Creating NeoBench OS directories..."
mkdir -p /mnt/neobench/{C,Libs,Prefs,Tools,Utilities,System,Temp,Dev,Storage}
mkdir -p /mnt/neobench/S
mkdir -p /mnt/neobench/S/Startup /mnt/neobench/S/Network /mnt/neobench/S/Boot
mkdir -p /mnt/neobench/Fonts /mnt/neobench/Docs /mnt/neobench/Logs

echo "🧠 Creating memory info files..."
echo "MC68060 CPU with MMU/FPU" > /mnt/neobench/Dev/CPU.info
echo "128 MB RAM minimum" > /mnt/neobench/Dev/RAM.info
echo "AGA chipset required" > /mnt/neobench/Dev/Video.info

echo "⚙️ Placing system bootstrap code..."
cat > /mnt/neobench/S/Startup/start.rs <<'EOF'
#![no_std]
#![no_main]

#[no_mangle]
pub extern "C" fn _start() -> ! {
    // Here you can initialize USB, SCSI, Bluetooth, and Networking
    loop {}
}
EOF

echo "✅ NeoBench OS base installed to /mnt/neobench"
