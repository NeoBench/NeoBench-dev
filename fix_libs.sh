#!/bin/bash
echo "Fixing lib.rs files..."

declare -A crates=(
  [startup]="_start_startup"
  [kernel]="_start_kernel"
  [boot]="_start_boot"
  [gui]="_start_gui"
)

for crate in "${!crates[@]}"; do
  path="src/$crate/src/lib.rs"
  func="${crates[$crate]}"
  echo "Fixing $path..."
  cat > "$path" <<END
#![no_std]
#![no_main]

#[no_mangle]
pub unsafe extern "C" fn $func() -> ! {
    loop {}
}
END
done

echo "Done."
