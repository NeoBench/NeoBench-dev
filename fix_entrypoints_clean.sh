#!/bin/bash
echo "🔧 Fixing entry points with valid #[no_mangle] syntax..."

declare -A crates=(
  [boot]="_start_boot"
  [startup]="_start_startup"
  [kernel]="_start_kernel"
  [gui]="_start_gui"
  [shell]="_start_shell"
  [fs]="_start_fs"
  [drivers]="_start_drivers"
)

for crate in "${!crates[@]}"; do
  path="src/$crate/src/lib.rs"
  entry="${crates[$crate]}"
  if [[ -f "$path" ]]; then
    echo "✔ Updating $path"
    cat > "$path" <<EOF
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $entry() -> ! {
    loop {}
}
EOF
  else
    echo "⚠ File not found: $path"
  fi
done

echo "✅ All lib.rs entry points restored."
