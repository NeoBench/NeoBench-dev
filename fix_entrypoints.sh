#!/bin/bash

declare -A modules=(
  [gui]="gui"
  [shell]="shell"
  [startup]="startup"
  [drivers]="drivers"
  [fs]="fs"
  [boot]="boot"
  [kernel]="kernel"
)

for module in "${!modules[@]}"; do
  file="src/${module}/src/lib.rs"
  func="_start_${module}"
  echo "→ Fixing $file"
  cat > "$file" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn ${func}() -> ! {
    loop {}
}
EOF
done

echo "✅ All entrypoints fixed."
