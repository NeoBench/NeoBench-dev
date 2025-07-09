#!/bin/bash
echo "Fixing all lib.rs entry points..."

declare -A modules=(
  [boot]="_start_boot"
  [kernel]="_start_kernel"
  [startup]="_start_startup"
  [gui]="_start_gui"
  [fs]="_start_fs"
  [drivers]="_start_drivers"
  [shell]="_start_shell"
)

for module in "${!modules[@]}"; do
  func="${modules[$module]}"
  path="src/$module/src/lib.rs"
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

echo "All entry points fixed."
