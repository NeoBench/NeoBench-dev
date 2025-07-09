#!/bin/bash
echo "🔧 Fixing NeoBench entrypoints..."

declare -A crates=(
  [kernel]="_start_kernel"
  [fs]="_start_fs"
  [boot]="_start_boot"
  [gui]="_start_gui"
)

for crate in "${!crates[@]}"; do
  path="src/$crate/src/lib.rs"
  entry="${crates[$crate]}"
  echo "✔ Overwriting $path"
  cat > "$path" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $entry() -> ! {
    loop {}
}
EOF
done

echo "✅ Entry points fixed."
